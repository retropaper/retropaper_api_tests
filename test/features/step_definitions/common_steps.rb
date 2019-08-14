require_relative '../support/helper_methods'
require 'json'
require 'rspec'

Given(/^"([^"]*)" service "([^"]*)" endpoint: "([^"]*)" is called with "([^"]*)" parameter$/) do |arg1, arg2, arg3, arg4|
  @build_endpoint = ''
  case arg2.upcase

  when "PERSON_API"
    case arg3.upcase
      when "HEALTH"
        @build_endpoint = "#{ENV['PERSON_API']}/#{ENV['HEALTH']}"
    when "PERSON"
      case arg4.upcase
        when "PERSON_ALL"
          @build_endpoint = "#{ENV['PERSON_API']}/#{ENV["#{arg4}"]}"
        when "BAD_REQUEST"
          @build_endpoint = "#{ENV['PERSON_API']}/#{ENV["#{arg4}"]}"
        else
          raise "Parameter: #{arg4} is incorrect. Please check your feature scenario and correct it"
      end


      else
        raise "Unable to find endpoint method. Please check your feature scenario and make sure endpoint method is correct: #{arg3}"
    end

  when "MOVIE_API"
    case arg3.upcase
      when "HEALTH"
        @build_endpoint = "#{ENV['MOVIE_API']}/#{ENV['HEALTH']}"
      when "MOVIE"
        case arg4.upcase
          when "MOVIE_ALL"
            @build_endpoint = "#{ENV['MOVIE_API']}/#{ENV["#{arg4}"]}"
          when "BAD_REQUEST"
            @build_endpoint = "#{ENV['MOVIE_API']}/#{ENV["#{arg4}"]}"
          else
            raise "Parameter: #{arg4} is incorrect. Please check your feature scenario and correct it"
        end
      else
        raise "Unable to find endpoint method. Please check your feature scenario and make sure endpoint method is correct: #{arg3}"
    end

  else
    raise "Unable to match API: #{arg2} condition in your feature scenario, please check your feature"
  end
  case arg1.downcase
    when "get"
      @res = Helper_Methods.get_request_without_auth @build_endpoint
    when "post"
      @res = Helper_Methods.post_request"", "", ""
    else
      raise "Unable to find service call method: #{arg1}, Please check your feature scenario and correct it"
  end
  p @res
end

Given(/^service status code should return "([^"]*)"$/) do |status_code|
    code = status_code
    respose_code = @res["http_code"]
    expect(respose_code.to_s).to eql(code.to_s)
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

Given(/^the response body should not be null$/) do
  @response = @res["message"]
  expect(@response).not_to be_nil
end

Then(/^"([^"]*)" service should return all user details$/) do |arg1|
  case arg1
  when "PERSON_API"
    puts @response

  else
    raise "Expected service method dose not exists. Please check your feature scenarios"
  end
end

Then(/^"([^"]*)" service should return all movie details$/) do |arg1|
  case arg1
  when "MOVIE_API"
    puts @response

  else
    raise "Expected service method dose not exists. Please check your feature scenarios"
  end
end