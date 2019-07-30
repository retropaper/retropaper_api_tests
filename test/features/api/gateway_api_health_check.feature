@GATEWAY_HEALTH_CHECK
Feature: BDSO Gateway API Service Helath Check

  @HIGH @HIGH_GATEWAY @ghc1
  Scenario: GATEWAY API service health check
    Given "BDSO_GATEWAY_API" service endpoint: "HEALTH" is called
    And service status code should return "200"
    And the response body should not be null
    Then service "status" should be "UP"


