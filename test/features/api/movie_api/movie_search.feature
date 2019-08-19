@MOVIE_API
Feature: MOVIE API: Movie Search
  Movie API will ensure endpoints are healthy and return expected results.
  Scopes:
    1. All movies : /api/v1/movie/all
    2. Movie By Id : /api/v1/movie/{id} id = (tt0000008)
    3. Search Movies : /api/v1/movie/search?title={title}&year={year}

  @HIGH1 @mov1
  Scenario: #001 Ensure movie API return all available movie details
    Given "GET" service "MOVIE_API" endpoint: "MOVIE" is called with "MOVIE_ALL" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "MOVIE_API" service should return all movie details

  @HIGH1 @mov2
  Scenario: #002 Ensure movie API return single movie movie details by movie id
    Given "GET" service "MOVIE_API" endpoint: "MOVIE" is called with "MOVIE_ID" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "MOVIE_API" api should return single movie details
    |id|tt0000008|
    |title|Edison Kinetoscopic Record of a Sneeze (1894) |
    |releaseYear|1894|
    |genres_genreId_1|1|
    |genres_movieId_1              |tt0000008|
    |genres_genre_1              |Documentary |
    |genres_genreId_2|2|
    |genres_movieId_2              |tt0000008|
    |genres_genre_2              |Short |
    |people_personId_1              |nm0000168 |
    |people_personType_1              |actor |
    |people_personId_2              |nm0000169 |
    |people_personType_2              |actor |
    |people_reviewId_1              |1 |
#
#
#  {
#  "id": "tt0000008",
#  "title": "Edison Kinetoscopic Record of a Sneeze (1894)",
#  "releaseYear": 1894,
#  "genres": [
#  {
#  "genreId": "1",
#  "movieId": "tt0000008",
#  "genre": "Documentary"
#  },
#  {
#  "genreId": "2",
#  "movieId": "tt0000008",
#  "genre": "Short"
#  }
#  ],
#  "people": [
#  {
#  "moviePrimaryPeopleId": {
#  "movieId": "tt0000008",
#  "personId": "nm0000168"
#  },
#  "personType": "actor"
#  },
#  {
#  "moviePrimaryPeopleId": {
#  "movieId": "tt0000008",
#  "personId": "nm0000169"
#  },
#  "personType": "actor"
#  }
#  ],
#  "reviews": [
#  {
#  "reviewId": 1,
#  "authorName": "Keonte Davis",
#  "dateCreated": 1565661207.000000000,
#  "name": "Test Review",
#  "reviewConent": "Some sample data to test content",
#  "reviewRating": 3,
#  "minReviewScale": 1,
#  "maxReviewScale": 5,
#  "movieId": "tt0000008"
#  },
#  {
#  "reviewId": 2,
#  "authorName": "Keonte Davis",
#  "dateCreated": 1565661207.000000000,
#  "name": "Test Review",
#  "reviewConent": "Some sample data to test content",
#  "reviewRating": 3,
#  "minReviewScale": 1,
#  "maxReviewScale": 5,
#  "movieId": "tt0000008"
#  }
#  ]
#  }


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


