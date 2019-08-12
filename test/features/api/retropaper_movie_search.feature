@retropaper_movie_API
Feature: Retropaper(Movie) API: Movie Search

  @HIGH @HIGH_GATEWAY @us1
  Scenario: #001 Ensure retropaper movie API return single all movie details
    Given "MOVIE_API" service endpoint: "MOVIE" is called with "all" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "MOVIE_API" service should return all movie details

  @HIGH @HIGH_GATEWAY @us2
  Scenario: #002 Ensure retropaper movie API return 400 status code for bad request
    Given "MOVIE_API" service endpoint: "MOVIE" is called with "all" parameter
    And service status code should return "400"

  @HIGH_hold @HIGH_GATEWAY_hold @us2
  Scenario Outline: #002 Ensure retropaper movie API return single movie details by movie ID
    Given "MOVIE_API" api service endpoint is called with "MOVIE" endpoint and "<movie_id>" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "MOVIE_API" api service should return following movie details
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
      | movie_id |
      | jdoe    |