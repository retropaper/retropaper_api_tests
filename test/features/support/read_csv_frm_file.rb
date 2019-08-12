
def read_csv(directory, csv_file_name)
  csv_directory = directory
  csv_path = "#{csv_directory}#{csv_file_name}"
  unless File.exist?(csv_path)
    flunk "File does not exists"
  end
  rd_csv = File.read(csv_path)
end

def csv(dir, json_file_name)
  data_directory = dir
  json_path = "#{data_directory}/#{json_file_name}.json"
  rd_json = File.read(json_path)
  json_data = JSON.load(rd_json) #, :quirks_mode => true)
  # puts json_data
  json_data_hash = JSON.parse(json_data)
  # return json_data_hash
end
