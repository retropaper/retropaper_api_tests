#!/usr/bin/ruby
require 'json'
require 'rest-client'
require_relative 'env'
require 'active_support'
require 'active_support/core_ext'
require_relative 'tools/rest_helper'

class Helper_Methods
  def Helper_Methods.get_request(url, role = 'Administrator', params={})
    get_response = {}
    no_log = params['no_log']
    params.delete('no_log')
    @params = params.values.join('/')
    if @params.empty?
      @url = url
    else
      @url = [url, @params].join('/')
    end
    #puts "Get Url: #{@url}"
    token = "#{ENV['TOKEN']}"
    headers = {'Authorization' => token}
   # p headers
    begin
      response = RestHelper.get(@url, role)
      # response = RestClient::Request.execute(:url => @url, :method => :get, :verify_ssl => false, :headers => headers,
      #                                        :open_timeout => 300, :timeout => 300)
      get_response['http_code'] = response.code
      get_response['status'] = response.code == 200 ? 'Success' : 'Failure'
      get_response['message'] = response.body
      get_response['headers'] = response.headers
      puts get_response if get_response['status'].eql? 'Failure'

      return get_response
    rescue StandardError => e
      get_response['status'] = 'Failure'
      get_response['http_code'] = e.message.nil? ? '500' : e.message[0, 3]
      if e.respond_to?('response')
        get_response['message'] = e.response
      else
        get_response['message'] = e.message
      end

      unless no_log
        puts get_response['message']
      end

      return get_response
    end
  end

  def Helper_Methods.get_request_without_auth(url, params={})
    get_response = {}
    no_log = params['no_log']
    params.delete('no_log')
    @params = params.values.join('/')
    if @params.empty?
      @url = url
    else
      @url = [url, @params].join('/')
    end
    puts "Get Url: #{@url}"
    headers = {}
    p headers
    begin
      response = RestHelper.get(@url, nil)
      # response = RestClient::Request.execute(:url => @url, :method => :get, :verify_ssl => false, :headers => headers)
      get_response['http_code'] = response.code
      get_response['status'] = response.code == 200 ? 'Success' : 'Failure'
      get_response['message'] = response.body

      puts get_response if get_response['status'].eql? 'Failure'

      return get_response
    rescue StandardError => e
      get_response['status'] = 'Failure'
      get_response['http_code'] = e.message.nil? ? '500' : e.message[0, 3]
      if e.respond_to?('response')
        get_response['message'] = e.response
      else
        get_response['message'] = e.message
      end

      unless no_log
        puts get_response['message']
      end

      return get_response
    end
  end

  def Helper_Methods.get_request_expired_token(url, expired_tokn, params={})
    get_response = {}
    no_log = params['no_log']
    params.delete('no_log')
    @params = params.values.join('/')
    expired_token = "#{expired_tokn}"
    headers = {'Authorization' => expired_token}
    p headers
    begin
      #response = RestHelper.get(@url, role)
      response = RestClient::Request.execute(:url => url, :method => :get, :verify_ssl => false, :headers => headers,
                                             :open_timeout => 300, :timeout => 300)
      get_response['http_code'] = response.code
      get_response['status'] = response.code == 200 ? 'Success' : 'Failure'
      get_response['message'] = response.body
      get_response['headers'] = response.headers
      puts get_response if get_response['status'].eql? 'Failure'
      return get_response
    rescue StandardError => e
      get_response['status'] = 'Failure'
      get_response['http_code'] = e.message.nil? ? '500' : e.message[0, 3]
      if e.respond_to?('response')
        get_response['message'] = e.response
      else
        get_response['message'] = e.message
      end
      unless no_log
        puts get_response['message']
      end
      return get_response
    end
  end

  def Helper_Methods.post_request(service, payload, role = 'Administrator')
    puts "Post URL: #{service}"
    # print "JSON:\n#{payload}\n\n"
    @post_response = {}
    headers = {:content_type => 'json', :accept => 'json'}
    begin
      response = RestHelper.post(@url, payload, role)
      # response = RestClient::Request.execute(:url => service, :method => :post, :verify_ssl => false, :payload => payload, :headers => headers)
    rescue StandardError => e
      @post_response['status'] = 'Failure'
      if e.message.nil?
        http_code = '500'
      else
        http_code = e.message[0, 3]
      end
      @post_response['http_code'] = http_code
      if e.respond_to?('response')
        @post_response['message'] = e.response
      else
        @post_response['message'] = e.message
      end
      puts @post_response['message']
      return @post_response
    end

    http_code = "#{response.code}"
    status = http_code.match(/20(\d)/) ? 'Success' : 'Failure'
    @post_response['status'] = status
    @post_response['http_code'] = http_code
    @post_response['message'] = response.body
    if status.eql?('Failure')
      p @post_response['message']
    end
    return @post_response
  end

  def self.valid_json?(json)
    begin
      JSON.parse(json)
      return true
    rescue JSON::ParserError => e
      return false
    end
  end

end
