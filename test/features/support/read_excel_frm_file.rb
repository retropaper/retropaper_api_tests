require 'yomu'


def yomu_excel_read(directory, excel_file_name)
  excel_file_path = "#{directory}#{excel_file_name}"
  yomu_excel = Yomu.new excel_file_path
end
