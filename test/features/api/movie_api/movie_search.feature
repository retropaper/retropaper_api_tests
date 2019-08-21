@MOVIE_API
Feature: MOVIE API: Movie Search
  Movie API will ensure endpoints are healthy and return expected results.
  Scopes:
  1. Movie By Id : /api/v1/movie/{id} id = (tt0000008)
  2. Search Movies : /api/v1/movie/search?title={title}&year={year}

  @HIGH1 @mov1
  Scenario Outline: #001 Ensure person API return available person details by person ID
    Given "GET" service "MOVIE_API" endpoint: "MOVIE" is called with "_ID" : "<id>" parameter
    And service status code should return "200"
    And the response body should not be null
    Then Person ID: "<id>" should match with the response
    And Full Name: "<fullname>" should match with the response
    And characters ID: "<characters_id>" and Movie ID: "<characters_movieId>" and Person ID: "<characters_personId>" and "<characters_fullName>" should match with the response
    Examples:
      | id        | fullname     | characters_id | characters_movieId | characters_personId | characters_fullName                                 |
      | nm0002071 | Will Ferrell | 246326        | tt1490017          | nm0002071           | Lord Business, President Business, The Man Upstairs |

  @HIGH1 @mov2
  Scenario: #002 Ensure movie API return single movie movie details by movie id
    Given "GET" service "MOVIE_API" endpoint: "MOVIE" is called with "MOVIE_ID" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "MOVIE_API" api should return single movie details
      | id                  | tt0000008                                     |
      | title               | Edison Kinetoscopic Record of a Sneeze (1894) |
      | releaseYear         | 1894                                          |
      | genres_genreId_1    | 1                                             |
      | genres_movieId_1    | tt0000008                                     |
      | genres_genre_1      | Documentary                                   |
      | genres_genreId_2    | 2                                             |
      | genres_movieId_2    | tt0000008                                     |
      | genres_genre_2      | Short                                         |
      | people_personId_1   | nm0000168                                     |
      | people_personType_1 | actor                                         |
      | people_personId_2   | nm0000169                                     |
      | people_personType_2 | actor                                         |
      | people_reviewId_1   | 1                                             |

  @HIGH1 @mov3
  Scenario: #003 Ensure movie API return single movie movie details by movie title
    Given "GET" service "MOVIE_API" endpoint: "MOVIE" is called with "MOVIE_TITLE" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "MOVIE_API" service should return all movie details

  @HIGH1 @mov4
  Scenario: #004 Ensure movie API return single movie movie details by movie released year
    Given "GET" service "MOVIE_API" endpoint: "MOVIE" is called with "MOVIE_RELEASED_YEAR" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "MOVIE_API" service should return all movie details

  @HIGH1 @mov5
  Scenario: #005 Ensure movie API return 400 status code with bad parameter
    Given "GET" service "MOVIE_API" endpoint: "MOVIE" is called with "BAD_REQUEST" parameter
    And service status code should return "400"


