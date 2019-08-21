@DOSSIER_API
Feature: DOSSIER API: Dossier search
  Dossier API will ensure endpoints are healthy and return expected results.
  Scopes:
  1. Dossier : return 200 and response body is not null

  @HIGH @dos1
  Scenario Outline: #001 Ensure DOSSIER API return 200 Status with dossier ID search and response body is not null
    Given "GET" service "DOSSIER_API" endpoint: "DOSSIER" is called with "DOSSIER_ID" : "<id>" parameter
    Then service status code should return "200"
    And the response body should not be null
    Examples:
      | id    |
      | 67161 |
      | 83835 |