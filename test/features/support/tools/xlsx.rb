require 'json'
require 'active_support'
require 'active_support/core_ext'
require_relative 'bdd_logger'
require 'roo'


class Xlsx
  def initialize(path)
    @xlsx = Roo::Spreadsheet.open(path)
  end

  def row_hash(sheet_id, key_column, value_column, range = (1..100000))
    sheet = @xlsx.sheet(sheet_id)
    result = {}
    range.each do |row_id|
      next unless sheet.cell(row_id, key_column).present?
      key = sheet.cell(row_id, key_column)
      value = sheet.cell(row_id, value_column)
      result[key] = value
    end

    result
  end

  def grid_hash(sheet_id, column_range = (1..100000), row_range = (1..100000))
    if column_range.size.odd?
      BddLogger.error('Column range should be even number')
      return
    end
    sheet = @xlsx.sheet(sheet_id)
    result = {}
    result['excel_location'] = "Sheet: #{sheet_id}, Column: #{column_range}, Row: #{row_range}"
    row_range.each do |row|
      column_range.each_slice(2) do |column|
        next unless sheet.cell(row, column[0]).present?
        key = sheet.cell(row, column[0])
        value = sheet.cell(row, column[1])
        result[key] = value
      end
    end
    result
  end

  def table_hashes(sheet_id, title_row)
    sheet = @xlsx.sheet(sheet_id)
    begin
      keys = sheet.row(title_row).reject {|o| o.blank?}
    rescue
      BddLogger.fail('Cannot parse xlsx properly!!')
    end
    result = []
    i = title_row
    while true
      i += 1
      this_row = sheet.row(i)
      break unless this_row.any? {|a| !a.nil? && a.size>0}
      obj = {}
      # obj['excel_location'] = "Sheet: #{sheet_id}, Row: #{i}"
      keys.each_with_index do |key, id|
        next unless key.present?
        obj[key] = this_row[id]
      end
      result << obj
    end

    result
  end

  def first_occurrence_row(sheet_id, key_word)
    sheet = @xlsx.sheet(sheet_id)
    result = 0
    found = false
    while result<sheet.last_row
      result += 1
      this_row = sheet.row(result)
      if this_row.include?(key_word)
        found = true
        break
      end
    end
    result = -1 unless found
    result
  end

  def sheets
    @xlsx.sheets
  end

end
