
def write_csv(export_directory, csv_file_name, csv_content)
  unless Dir.exist?(export_directory)
    Dir.mkdir(export_directory, 0777)
  end
  File.open("#{export_directory}#{csv_file_name}",'w') do |f|
    f.write(csv_content)
  end
end