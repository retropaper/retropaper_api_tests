require 'rspec'
require 'json'
require 'json-schema'
require 'time'

def convert_time time_string, time_format
    time = Time.parse(time_string)
    time.strftime(time_format)
    #time.strftime("%y-%m-%d")
    return time
end




