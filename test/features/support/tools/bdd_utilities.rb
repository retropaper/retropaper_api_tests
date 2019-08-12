require 'json'
# require 'nokogiri'

class BddUtilities
  def self.json_string?(string)
    JSON.parse(string)
    return true
  rescue JSON::ParserError => e
    return false
  end

  def self.xml_string?(string)
    # xml = Nokogiri::XML(string)
    # xml.errors.size < 1
    string.include?('<?xml version=')
  end
end