@MOVIE_API
Feature: MOVIE API: Movie Search
  Movie API will ensure endpoints are healthy and return expected results.
  Scopes:
  1. Movie By Id : return 200 and response body is not null

  @HIGH @mov1
  Scenario Outline: #001 Ensure Movie API return 200 Status with movie ID search and response body is not null
    Given "GET" service "MOVIE_API" endpoint: "MOVIE" is called with "MOVIE_ID" : "<id>" parameter
    Then service status code should return "200"
    And the response body should not be null
    Examples:
      | id        |
      | tt6291460 |
      | tt1702425 |
      | tt1608290 |
      | tt5657846 |
      | tt1528854 |
      | tt1001526 |
      | tt1790886 |
      | tt4481514 |
      | tt1255919 |
      | tt0457400 |
