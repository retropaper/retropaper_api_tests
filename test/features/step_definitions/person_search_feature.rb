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
  expect(@act_char_full_name.gsub(/[^a-zA-Z0-9\-]/,"") ).to eql(@exp_char_full_name.gsub(/[^a-zA-Z0-9\-]/,""))
end

And(/^expected "([^"]*)" json file should match with the response$/) do |file_name|
  file_name_not_null = file_name
  if file_name_not_null == nil
    @file_if_null = file_name_not_null == nil ? 'null' : file_name_not_null
    fail("Expected JSON file: (#{file_name}) but got #{@file_if_null}")
  end
  @response = @res["message"]
  @act_response = JSON.parse(@response)

  expected_data = (read_json "#{file_name}")



  p "expected_data: #{expected_data}"
  p "#############################################"
  p "@act_response: #{@act_response}"

  expect(@act_response).to eql(expected_data)
  # expect(@act_response).to include(expected_data)
  #
  #
  #
  #
  # expect(JSON.parse(@act_response)).to eq (JSON.parse(expected_data))

end