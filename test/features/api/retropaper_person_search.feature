@retropaper_person_API
Feature: Retropaper(Person) API: Person Search

  @HIGH @HIGH_GATEWAY @us1
  Scenario: #001 Ensure retropaper person API return single all user details
    Given "PERSON_API" service endpoint: "PERSON" is called with "all" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "PERSON_API" service should return all user details

  @HIGH @HIGH_GATEWAY @us2
  Scenario: #002 Ensure retropaper person API return 400 status code for bad request
    Given "PERSON_API" service endpoint: "PERSON" is called with "all" parameter
    And service status code should return "400"

  @HIGH_hold @HIGH_GATEWAY_hold @us2
  Scenario Outline: #002 Ensure retropaper person API return single person details by person ID
    Given "PERSON_API" api service endpoint is called with "PERSON" endpoint and "<person_id>" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "PERSON_API" api service should return following person details
      | id               | 1              |
      | createdBy        | Temp Test      |
      | createdDate      | 1562943215.703 |
      | lastModifiedBy   | Temp Test      |
      | lastModifiedDate | 1562943215.703 |
      | firstName        | John           |
      | lastName         | Doe            |
      | dob              | 12/32/1989     |
      | userId           | jdoe           |
    Examples:
      | person_id |
      | jdoe    |