require 'active_support'
require 'active_support/core_ext'
require 'rest-client'
require_relative 'bdd_utilities'
require_relative 'bdd_logger'
require 'jwt'
require_relative '../../../../Test/features/support/env_int'

class RestHelper

  def self.send_request(url, request_type, payload_string='', header_hash={})
    unless payload_string.is_a?(String)
      raise "Expect payload is a string, but it is a #{payload_string.class}"
    end
    params = {:url => url,
              :method => request_type.downcase,
              :verify_ssl => false,
              :headers => header_hash,
              :payload => payload_string,
              :open_timeout => 300,
              :timeout => 300
    }
    begin
      response = RestClient::Request.execute(params)
      return response
    rescue => e
      response = e.response
      return response
    end
  end

  def self.build_headers(token, payload_string)
    @headers = {}
    @headers[:authorization] = "Bearer #{token}" unless token.nil? #this is used to provide no token in auth tests
    if BddUtilities.json_string?(payload_string)
      @headers[:accept] = @headers[:content_type] = 'application/json'
    elsif BddUtilities.xml_string?(payload_string)
      @headers[:accept] = @headers[:content_type] = 'application/xml'
    end
    @headers
  end

  def self.get(url, role='Administrator', payload_string='')
    build_headers(AccessToken.token(role), payload_string)
    start_time = Time.now
    response = send_request(url, :get, payload_string, @headers)
    end_time = Time.now
    dur = end_time - start_time
    BddLogger.info "#{Time.now.localtime.to_s} Complete GET URL: \t#{url}, duration: #{dur} seconds"
    response
  end

  def self.post(url, payload_string='', role='Administrator')
    build_headers(AccessToken.token(role), payload_string)
    BddLogger.info "#{Time.now.localtime.to_s} Start GET URL: \t#{url}"
    send_request(url, :post, payload_string, @headers)
  end

  def self.put(url, payload_string='', role='Administrator')
    build_headers(AccessToken.token(role), payload_string)
    BddLogger.info "#{Time.now.localtime.to_s} Start GET URL: \t#{url}"
    send_request(url, :put, payload_string, @headers)
  end
end

class AccessToken
  @tokens = {}

  def self.token(role)
    return nil if role.nil?
    return nil if role.downcase.include?('no') && role.downcase.include?('token')
    if role.downcase.start_with?('admin')
      data_hash = {roles: ['Administrator'], aud: ENV['AUTH0_CLIENT_ID']}
    else
      data_hash = {roles: ['test'], aud: ENV['AUTH0_CLIENT_ID']}
      data_hash['https://test.gov test'] = role
    end
    encode(role, data_hash)
  end

  def self.center(center)
    affiliation = 'https://test.gov test'
    data_hash = {roles: ['admin'], aud: ENV['AUTH0_CLIENT_ID']}
    data_hash[affiliation] = center
    encode(center, data_hash)
  end

  private_class_method def self.encode(role, data_hash)
                         if @tokens[role].present?
                           BddLogger.info("Access: #{role} token has been generated already, no need to generate again")
                         else
                           if ENV['STAGE_TOKEN'].nil?
                             @tokens[role] = JWT.encode(data_hash, ENV['AUTH0_CLIENT_SECRET'], 'HS256')
                           else
                             @tokens[role] = ENV['STAGE_TOKEN']
                           end
                           BddLogger.info("A #{@tokens[role].length} digi #{role} token has been generated")
                         end
                         @tokens[role]
                       end
end



