require "json-diff"
require 'json-compare'
require 'json'
require 'jwt'
require 'uri'
require 'net/http'

class Utility_Helper

  def Utility_Helper.download_file(file_path, file_name, service_url)
    tkn = AccessToken.token('Admin')
    token = "authorization: bearer #{tkn}"
    cache = "cache-control: no-cache"
    fl_nm = "#{file_path}#{file_name}"
    cmd = "curl -o '#{fl_nm}' -X GET '#{service_url}' -H '#{token}' -H '#{cache}'"
    `#{cmd}`
    p `#{$?.exitstatus}`
  end

  def Utility_Helper.download_excel_file(file_path, file_name, service_url)
    tkn = AccessToken.token('Admin')
    token = "authorization: bearer #{tkn}"
    cache = "cache-control: no-cache"
    cmd = "curl -o '#{file_path}#{file_name}' -X GET '#{service_url}' -H '#{token}' -H '#{cache}'"
    `#{cmd}`
    p `#{$?.exitstatus}`
  end

  def Utility_Helper.write_xls(export_directory, xls_file_name, xls_content)
    unless Dir.exist?(export_directory)
      Dir.mkdir(export_directory, 0777)
    end
    File.open("#{export_directory}#{xls_file_name}",'w') do |f|
      f.write(xls_content)
    end
  end

  def Utility_Helper.write_csv(export_directory, csv_file_name, csv_content)
    unless Dir.exist?(export_directory)
      Dir.mkdir(export_directory, 0777)
    end
    File.open("#{export_directory}#{csv_file_name}",'w') do |f|
      f.write(csv_content)
    end
  end

  def Utility_Helper.write_json(dir_path, json_file_name, json_content)
    unless Dir.exist?(dir_path)
      Dir.mkdir(dir_path, 0777)
    end
    File.open("#{dir_path}#{json_file_name}.json","w") do |f|
      f.write(json_content.to_json)
    end
  end

  def Utility_Helper.json_diff(expected_json, actual_json)
    # result = (expected_json.to_a - actual_json.to_a).flatten
    # return result
    h1 = expected_json
    h2 = actual_json
    result = {}
    h1.each {|k, v| result[k] = h2[k] if h2[k] != v }
    return result
  end

  def Utility_Helper.json_key_size(hash, key_name)
    data = hash
    select_keys = data.select{|d|d.key?("#{key_name}")}
    size_count = select_keys.size
    return size_count
  end

  def Utility_Helper.json_key_exists(hash, key_name)
    data = hash
    select_keys = data.select{|d|d.key?("#{key_name}")}
    size_count = select_keys.size
    return size_count
  end

end








