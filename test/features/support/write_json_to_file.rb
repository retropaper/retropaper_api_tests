

def write_json(dir_path, json_file_name, json_content)
  unless Dir.exist?(dir_path)
    Dir.mkdir(dir_path, 0777)
  end
  File.open("#{dir_path}#{json_file_name}.json","w") do |f|
    f.write(json_content.to_json)
  end
end