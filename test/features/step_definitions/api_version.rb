require_relative '../support/helper_methods'
require 'json'
require 'rspec'

Given(/^"([^"]*)" endpoint is called$/) do |arg1|
  @url = "#{ENV['HOSTNAME']}#{ENV[arg1]}"
  p "#{arg1} query endpoint: " + @url
  @res = Helper_Methods.get_request(@url)
end

Then(/^the service status code should return "([^"]*)"$/) do |arg1|
  code = arg1
  respose_code = @res["http_code"]
  expect(respose_code.to_s).to eql(code.to_s)
end

Then(/^the version "([^"]*)" is returned$/) do |arg1|
  @response = @res["message"]
  expect(@response).not_to be_nil
  response_body_hash = JSON.parse(@response)
  response_body_hash.each {|keys_value|
    p keys_value
    expect(keys_value.has_key?('name')).to eql true
    p keys_value['name']
    expect(keys_value['name']).to include(arg1)
  }
  expect{
    JSON.parse(@res["message"])
  }.to_not raise_error
end
