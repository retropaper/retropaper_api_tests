@retropaper_movie_API
Feature: Dossier: Create new dossier

  Scenario: #001 Ensure retropaper movie API return single all movie details
    Given "MOVIE_API" service endpoint: "MOVIE" is called with "all" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "MOVIE_API" service should return all movie details

  Scenario: #002 Ensure retropaper movie API return 400 status code for bad request
    Given "MOVIE_API" service endpoint: "MOVIE" is called with "all" parameter
    And service status code should return "400"

