@PERSON_API
Feature: Person API: Search for person

  @HIGH @ps1
  Scenario: #001 Ensure person API return all available user or person details
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_ALL" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "PERSON_API" service should return all user details

  @HIGH @ps2
  Scenario: #002 Ensure retropaper person API return 400 status code for bad request
    Given "PERSON_API" service endpoint: "PERSON" is called with "all" parameter
    And service status code should return "400"
