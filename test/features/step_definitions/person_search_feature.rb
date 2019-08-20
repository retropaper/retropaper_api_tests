require_relative '../support/helper_methods'
require 'json'
require 'rspec'

Then(/^Person ID: "([^"]*)" should match with the response$/) do |arg1|
  @response_body = JSON.parse(@response)
  exp_person_id = arg1
  act_person_id = @response_body['id'].to_i
  p "act_person_id: #{act_person_id}"
  act_person_id.eql?(exp_person_id.to_i) ? (p "expected: #{exp_person_id} got: #{act_person_id}, Step Assertion Passed") : fail("expected: #{exp_person_id} got: #{act_person_id}, Step Assertion Failed")
end

Then(/^person ID "([^"]*)" should match with the response person ID$/) do |arg1|
  @response_body = JSON.parse(@response)
  exp_person_id = arg1.to_s
  p "exp_person_id: #{exp_person_id.to_s}"
  act_person_id = @response_body[0]['id']
  p "act_person_id: #{act_person_id.to_s}"
  act_person_id.to_i.eql?(exp_person_id.to_i) ? (p "expected: #{exp_person_id} got: #{act_person_id}, Step Assertion Passed") : fail("expected: #{exp_person_id} got: #{act_person_id}, Step Assertion Failed")
end

Then(/^Full Name: "([^"]*)" should match with the response$/) do |arg1|
  exp_person_fn = arg1.to_s
  act_person_fn = @response_body['fullName'].to_s
  p "act_person_fn: #{act_person_fn}"
  act_person_fn.eql?(exp_person_fn) ? (p "expected: #{exp_person_fn} got: #{act_person_fn}, Step Assertion Passed") : fail("expected: #{exp_person_fn} got: #{act_person_fn}, Step Assertion Failed")
end

Then(/^person full Name "([^"]*)" should match with the response person full name$/) do |arg1|
  exp_person_fn = arg1.to_s
  act_person_fn = @response_body[0]['fullName'].to_s
  p "act_person_fn: #{act_person_fn}"
  act_person_fn.eql?(exp_person_fn) ? (p "expected: #{exp_person_fn} got: #{act_person_fn}, Step Assertion Passed") : fail("expected: #{exp_person_fn} got: #{act_person_fn}, Step Assertion Failed")
end

Then(/^characters ID: "([^"]*)" and Movie ID: "([^"]*)" and Person ID: "([^"]*)" and "([^"]*)" should match with the response$/) do |characters_id, characters_movie_id, characters_person_id, characters_full_name|
  exp_char_id = characters_id
  exp_char_movie_id = characters_movie_id
  exp_char_pers_id = characters_person_id
  p "characters_full_name: [#{characters_full_name}]"
  @exp_char_full_name = ""
  characters_full_name.each_char.map do |char|
    (char =~ /[[:alpha:]]/) ? @flag = true : @flag = false
  end
  p "@flag: #{@flag}"
  if @flag
    @exp_char_full_name = characters_full_name.to_s
  else
    @exp_char_full_name = characters_full_name.gsub!(/[^0-9A-Za-z]/, '')
  end
  p "******************************************"
  p "exp_char_id: #{exp_char_id}"
  p "exp_char_movie_id: #{exp_char_movie_id}"
  p "exp_char_pers_id: #{exp_char_pers_id}"
  p "exp_char_full_name: #{@exp_char_full_name}"
  p "******************************************"
  act_char_id = @response_body["characters"].map {|h1| h1['id'] if h1['id']==characters_id.to_i}.compact.first
  act_char_movie_id = @response_body["characters"].map {|h1| h1['movieId'] if h1['id']==characters_id.to_i}.compact.first
  act_char_pers_id = @response_body["characters"].map {|h1| h1['personId'] if h1['id']==characters_id.to_i}.compact.first
  @act_char_full_name = ""
  act_char_full_name = @response_body["characters"].map {|h1| h1['fullName'] if h1['id']==characters_id.to_i}.compact.first
  act_char_full_name.each_char.map do |chara|
    (chara =~ /[[:alpha:]]/) ? @act_flag = true : @act_flag = false
  end
  p "@act_flag: #{@act_flag}"
  if @act_flag
    @act_char_full_name = act_char_full_name.to_s
  else
    @act_char_full_name = act_char_full_name.gsub!(/[^0-9A-Za-z]/, '')
  end
  p "act_char_id: #{act_char_id}"
  p "act_char_movie_id: #{act_char_movie_id}"
  p "act_char_pers_id: #{act_char_pers_id}"
  p "act_char_full_name: #{@act_char_full_name}"
  p "******************************************"
  expect(act_char_id.to_s).to eql(exp_char_id.to_s)
  expect(act_char_movie_id.to_s).to eql(exp_char_movie_id.to_s)
  expect(act_char_pers_id.to_s).to eql(exp_char_pers_id.to_s)
  expect(@act_char_full_name.gsub(/[^a-zA-Z0-9\-]/,"")).to eql(@exp_char_full_name.gsub(/[^a-zA-Z0-9\-]/,""))
end

And(/^expected "([^"]*)" json file parameter: "([^"]*)" should match with the response$/) do |file_name, parameter_val|
  file_name_not_null = file_name
  if file_name_not_null == nil
    @file_if_null = file_name_not_null == nil ? 'null' : file_name_not_null
    fail("Expected JSON file: (#{file_name}) but got #{@file_if_null}")
  end
  @response_msg = @res["message"]
  @response_string = @response_msg.to_s.gsub(/\\n/, "").gsub(/\\"/, '"')
  @response_parse = JSON.parse(@response_string)
  expected_data = (read_json "#{file_name}")[parameter_val]
  expected_parse = expected_data.to_json
  expected_string = expected_parse.to_s.gsub(/\\n/, "").gsub(/\\"/, '"')
  expected_parse = JSON.parse(expected_string)
  expect(@response_parse).to eq(expected_parse)
end

Given(/^Search Term: "([^"]*)" should match with the response ID: "([^"]*)" and Full Name: "([^"]*)"$/) do |arg1, arg2, arg3|
  flag = false
  search_term_value = arg1.downcase
  @response = @res["message"]
  response_body_hash = JSON.parse(@response)
  response_body_hash.each {|keys_value|
    if keys_value['id'] == arg2
      p "keys_value: #{keys_value}"
      p "keys_value id: #{keys_value['id']}"
      p "keys_value full name: #{keys_value['fullName']}"
      expect(keys_value['id']).to eq(arg2), "ID does not match"
      expect(keys_value['fullName'].downcase).to include(search_term_value), "Full Name: #{keys_value['fullName']} does not contain search term: #{search_term_value}"
      expect(keys_value['fullName']).to eq(arg3), "Full Name does not match"
      flag = true
      break
    end
  }
  if flag.eql? true
    p "Matching ID: #{arg2} and Search Term: #{arg1} includes in the Full Name: #{arg3} identified in the json response, Test Step Passed"
  else
    fail("Matching ID: #{arg2} and Search Term: #{arg1} includes in the Full Name: #{arg3} Could not identified in the json response, Test Step Failed")
  end
end

Given(/^CREW ID: "([^"]*)", Movie ID: "([^"]*)", Person ID: "([^"]*)" and Person Type: "([^"]*)"  should match with the response$/) do |arg1, arg2, arg3, arg4|
  flag = false
  @response = @res["message"]
  response_body_hash = JSON.parse(@response)
  response_body_hash[0]['crew'].each {|keys_value|
    if keys_value['movieId'] == arg2
      p "keys_value: #{keys_value}"
      p "keys_value Id: [#{keys_value['id']}]"
      p "keys_value movieId: [#{keys_value['movieId']}]"
      p "keys_value personId: [#{keys_value['personId']}]"
      p "keys_value personType: [#{keys_value['personType']}]"
      expect(keys_value['id'].to_s.gsub(/[^a-zA-Z0-9\-]/,"")).to eq(arg1), "ID does not match"
      expect(keys_value['movieId'].to_s.gsub(/[^a-zA-Z0-9\-]/,"")).to eq(arg2), "Movie ID does not match"
      expect(keys_value['personId'].to_s.gsub(/[^a-zA-Z0-9\-]/,"")).to eq(arg3), "Person ID does not match"
      expect(keys_value['personType'].to_s.gsub(/[^a-zA-Z0-9\-]/,"")).to eq(arg4), "Person Type does not match"
      flag = true
      break
    end
  }
  if flag.eql? true
    p "Matching Movie ID: #{arg2} and Search crew movie ID: #{arg1} with the json response, Test Step Passed"
  else
    fail("Matching Movie ID: #{arg2} and Search crew movie ID: #{arg1} with the json response, Test Step Failed")
  end
end

Given(/^CHARACTERS ID: "([^"]*)", Movie ID: "([^"]*)", Person ID: "([^"]*)" and Full Name: "([^"]*)"  should match with the response$/) do |arg1, arg2, arg3, arg4|
  flag = false
  @response = @res["message"]
  response_body_hash = JSON.parse(@response)
  response_body_hash[0]['characters'].each {|keys_value|
    if keys_value['movieId'] == arg2
      p "keys_value: #{keys_value}"
      p "keys_value Id: [#{keys_value['id']}]"
      p "keys_value movieId: [#{keys_value['movieId']}]"
      p "keys_value personId: [#{keys_value['personId']}]"
      p "keys_value personType: [#{keys_value['fullName']}]"
      expect(keys_value['id'].to_s.gsub(/[^a-zA-Z0-9\-]/,"")).to eq(arg1), "ID does not match"
      expect(keys_value['movieId'].to_s.gsub(/[^a-zA-Z0-9\-]/,"")).to eq(arg2), "Movie ID does not match"
      expect(keys_value['personId'].to_s.gsub(/[^a-zA-Z0-9\-]/,"")).to eq(arg3), "Person ID does not match"
      expect(keys_value['fullName'].to_s.gsub(/[^a-zA-Z0-9\-]/,"")).to eq(arg4.to_s.gsub(/[^a-zA-Z0-9\-]/,"")), "Person Type does not match"
      flag = true
      break
    end
  }
  if flag.eql? true
    p "Matching Movie ID: #{arg2} and Search Character movie ID: #{arg1} with the json response, Test Step Passed"
  else
    fail("Matching Movie ID: #{arg2} and Search Character movie ID: #{arg1} with the json response, Test Step Failed")
  end
end



