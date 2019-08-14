@MOVIE_API
Feature: MOVIE API: Movie Search

  @HIGH @us1
  Scenario: #001 Ensure movie API return all available movie details
    Given "GET" service "MOVIE_API" endpoint: "MOVIE" is called with "MOVIE_ALL" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "MOVIE_API" service should return all movie details

  @HIGH @us2
  Scenario: #002 Ensure movie API return 400 status code with bad parameter
    Given "GET" service "MOVIE_API" endpoint: "MOVIE" is called with "BAD_REQUEST" parameter
    And service status code should return "400"




