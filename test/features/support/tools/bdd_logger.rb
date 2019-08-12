class BddLogger
  @hide_log = false
  @project_name = 'TEST'

  def project(project)
    @project_name = project.upcase
  end

  def self.hide_log(hide=true)
    @hide_log = hide
  end

  def self.info(message, print_time=false)
    return if @hide_log
    time = print_time ? " #{Time.now.to_s} " : ''
    puts "[#{@project_name}_BDD_INFO#{time}]: #{message}" unless @hide_log
  end

  def self.error(message)
    puts "[#{@project_name}_BDD_ERROR #{Time.now.to_s} ]: #{message}"
  end

  def self.warning(message)
    puts "[#{@project_name}_BDD_WARNING #{Time.now.to_s} ]: #{message}"
  end

  def self.fail(message)
    puts "[#{@project_name}_BDD_FAIL #{Time.now.to_s} ]: #{message}"
    raise message
  end
end