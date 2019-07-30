class Object_Repository


  def Object_Repository.getLocators(field_name)
    obj_rep = File.join(File.dirname(__FILE__), + "../../public/object_repository.json")
    if File.exist? (obj_rep)
      flag = false
      objRepHash = JSON(IO.read(obj_rep))
      objRepHash.each do |obj|
        if obj["object_name"] == field_name
          flag = true
          return obj
        end
      end
      if flag == false
        return nil
      end
    end
  end

end