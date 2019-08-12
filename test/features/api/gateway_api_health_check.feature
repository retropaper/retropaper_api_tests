@GATEWAY_HEALTH_CHECK
Feature: BDSO Gateway API Service Health Check

  @HIGH_hold @HIGH_GATEWAY_hold @ghc1
  Scenario: retropaper API service health check
    Given "PERSON_API" service endpoint: "HEALTH" is called
    And service status code should return "200"
    And the response body should not be null
    Then service "status" should be "UP"


