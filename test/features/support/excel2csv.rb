# encoding: UTF-8
#!/usr/bin/env ruby

require 'rubygems'
# require 'roo'
require 'csv'

USAGE = <<END
Convert an excel file to csv

Example usage:
# Print the csv to std out
  excel2csv file.xls

# Write the csv to file
  excel2csv file.xls out.csv

END

def convert_excel_2_csv(input_xlsx_file_name, output_csv_file_name)
   excel = ''
  if input_xlsx_file_name =~ /xlsx$/
    excel = Roo::Excelx.new(input_xlsx_file_name, {:expand_merged_ranges => true})
  else
    excel = Roo::Excel.new(input_xlsx_file_name)
  end
  if input_xlsx_file_name
    excel.to_csv("#{input_xlsx_file_name}")
  else
    die_with_usage "You must pass a CSV file." unless output_csv_file_name
  end
end

def die_with_usage(msg=nil)
  puts USAGE
  puts msg if msg
  exit
end

def excel2csv(filename, output)

  # filename = ARGV[0]

  # die_with_usage "You must pass a file." unless filename

  if filename =~ /xlsx$/
    excel = Roo::Excelx.new(filename)
  else
    excel = Roo::Excel.new(filename)
  end

  output = STDOUT
  if ARGV[1]
    output = File.open(ARGV[1], "w")
  end

  1.upto(excel.last_row) do |line|
    output.write CSV.generate_line excel.row(line)
  end

end

