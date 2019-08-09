@BIOMETRICS_APPLICANT_API
Feature: BDSO(APPLICANT) API: User Search

  @HIGH @HIGH_GATEWAY @us1
  Scenario: #001 Ensure BDSO GATEWAY API return single all user details
    Given "APPLICANT_API" service endpoint: "USERS" is called with "all" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "APPLICANT_API" service should return all user details

  @HIGH @HIGH_GATEWAY @us2
  Scenario: #002 Ensure BDSO GATEWAY API return 400 status code for bad request
    Given "APPLICANT_API" service endpoint: "USERS" is called with "all" parameter
    And service status code should return "400"

  @HIGH_hold @HIGH_GATEWAY_hold @us2
  Scenario Outline: #002 Ensure BDSO GATEWAY API return single user details by user ID
    Given "APPLICANT_API" api service endpoint is called with "USERS" endpoint and "<user_id>" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "APPLICANT_API" api service should return following users details
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
      | user_id |
      | jdoe    |