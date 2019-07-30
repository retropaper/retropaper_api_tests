require_relative '../support/helper_methods'
require 'json'
require 'rspec'

And(/^the response for "([^"]*)" endpoints is not null$/) do |arg1|
  @response = @res["message"]
  expect(@response).not_to be_nil
  response_body_hash = JSON.parse(@response)
  response_body_hash.each {|keys_value|
    p keys_value
  }
  expect{
    JSON.parse(@res["message"])
  }.to_not raise_error
end

And(/^the response body should include "([^"]*)"$/) do |arg1|
  actual_status = JSON.parse(@response)
  #connected_message = actual_status[2]
  expect(actual_status.to_s).to include(arg1)
  exp_status = read_json "status_health_check"
 # expect(actual_status).to eql(exp_status)
end