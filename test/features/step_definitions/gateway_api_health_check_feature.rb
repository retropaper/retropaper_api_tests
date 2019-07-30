require_relative '../support/helper_methods'
require 'json'
require 'rspec'


# Then(/^service status code should return "([^"]*)"$/) do |status_code|
#   code = status_code
#   respose_code = @res["http_code"]
#   expect(respose_code.to_s).to eql(code.to_s)
# end
#
# And(/^the response body should not be null$/) do
#   @response = @res["message"]
#   p@response
#   expect(@response).not_to be_nil
# end

Given(/^"([^"]*)" service endpoint: "([^"]*)" is called$/) do |arg1, arg2|
  @build_endpoint = ''
  case arg1
  when "BDSO_GATEWAY_API"
    case arg2
      when "HEALTH"
        @build_endpoint = "#{ENV['GATEWAY_HOSTNAME']}/#{ENV['HEALTH']}"
      else
        raise "Unable to find endpoint method. Please check your feature scenario and make sure endpoint method is correct: #{arg2}"
    end
  when "bdso-analytics"
  #   place holder
  when "bdso-biometrics"
    #   place holder
  else
    raise "Unable to match API: #{arg1} condition in your feature scenario, please check your feature"
  end
  @res = Helper_Methods.get_request_without_auth(@build_endpoint)
  p @res
end

Given(/^service status code should return "([^"]*)"$/) do |status_code|
    code = status_code
    respose_code = @res["http_code"]
    expect(respose_code.to_s).to eql(code.to_s)
end

Given(/^the response body should not be null$/) do
    @response = @res["message"]
    p@response
    expect(@response).not_to be_nil
end

Then(/^service "([^"]*)" should be "([^"]*)"$/) do |arg1, arg2|
  expected_val = "#{arg2}"
  case arg1
  when "status"
    @response_body = JSON.parse(@response)
    act_serv_stats = @response_body['status'].to_s
    p "act_serv_stats: #{act_serv_stats}"
    expect(expected_val.to_s).to eql(act_serv_stats.to_s)
  else
    raise "Please check your feature scenario and make sure service status: #{arg1} exists"
  end
end

