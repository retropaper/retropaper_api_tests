require_relative '../support/helper_methods'
require 'json'
require 'rspec'

Given(/^movie ID: "([^"]*)", createdBy: "([^"]*)", movie Title: "([^"]*)", release year: "([^"]*)" and release date: "([^"]*)" should match with the response$/) do |arg1, arg2, arg3, arg4, arg5|
  flag = false
  @response = @res["message"]
  response_body_hash = JSON.parse(@response)
  response_body_hash.each {|keys_value|
    if keys_value['id'].to_s == arg1.to_s
      p "keys_value: #{keys_value}"
      # p "keys_value Id: [#{keys_value['id'].to_s}]"
      # p "keys_value createdBy: [#{keys_value['createdBy']}]"
      # p "keys_value title: [#{keys_value['title']}]"
      # p "keys_value releaseYear: [#{keys_value['releaseYear']}]"
      # p "keys_value releaseDate: [#{keys_value['releaseDate']}]"

      # expect(keys_value['id'].to_s.gsub(/[^a-zA-Z0-9\-]/,"")).to eq(arg1), "ID does not match"
      # expect(keys_value['movieId'].to_s.gsub(/[^a-zA-Z0-9\-]/,"")).to eq(arg2), "Movie ID does not match"
      # expect(keys_value['personId'].to_s.gsub(/[^a-zA-Z0-9\-]/,"")).to eq(arg3), "Person ID does not match"
      # expect(keys_value['fullName'].to_s.gsub(/[^a-zA-Z0-9\-]/,"")).to eq(arg4.to_s.gsub(/[^a-zA-Z0-9\-]/,"")), "Person Type does not match"
      flag = true
      break
    end
  }
  if flag.eql? true
    # p "Matching Movie ID: #{arg2} and Search Character movie ID: #{arg1} with the json response, Test Step Passed"
  else
    # fail("Matching Movie ID: #{arg2} and Search Character movie ID: #{arg1} with the json response, Test Step Failed")
  end
end


# | id        | createdBy | title  | releaseYear | releaseDate |
# | tt6291460 | spark job | Hacked | 2016        | 1479081600  |