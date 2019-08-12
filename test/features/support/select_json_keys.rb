require "json-diff"
require 'json-compare'
require 'json'
require 'jwt'
require 'uri'
require 'net/http'


class Hash
    def select_keys(*args)
        select {|k,v| args.include?(k) }
    end
end

