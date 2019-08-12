require 'rspec'
require 'json'
require 'json-schema'

def read_json json_file
    data_directory = "#{Dir.pwd}/public/resources/data"
    json_path = "#{data_directory}/#{json_file}.json"
    rd_json = File.read(json_path)
    json_data_hash = JSON.parse(rd_json)
    return json_data_hash
end

def read_json_from_dir(dir, json_file_name)
    data_directory = dir
    json_path = "#{data_directory}/#{json_file_name}.json"
    rd_json = File.read(json_path)
    json_data = JSON.load(rd_json) #, :quirks_mode => true)
   # puts json_data
    json_data_hash = JSON.parse(json_data)
   # return json_data_hash
end


