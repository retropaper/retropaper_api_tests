@PERSON_API
Feature: PERSON API: Search for person
  Person API will ensure endpoints are healthy and return expected results.
  Scopes:
  1. Person by Id : /api/v1/person/{id} id = nm0002071
  2. People by Name : /api/v1/person/name/{name}
  3. Search People : /api/v1/person/search?term={term}
  4. Search Crew : /api/v1/person/crew/{movieId} - Returns the Person records for all of the crew in a given movie
  5. Search Characters : /api/v1/person/characters/{movieId} - Returns the Person records for all of the character in a given movie

  @HIGH @ps1
  Scenario Outline: #001 Ensure person API return available person details by person ID
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_ID" : "<id>" parameter
    And service status code should return "200"
    And the response body should not be null
    Then Person ID: "<id>" should match with the response
    And Full Name: "<fullname>" should match with the response
    And characters ID: "<characters_id>" and Movie ID: "<characters_movieId>" and Person ID: "<characters_personId>" and "<characters_fullName>" should match with the response
    Examples:
      | id        | fullname     | characters_id | characters_movieId | characters_personId | characters_fullName   |
      | nm0002071 | Will Ferrell | 395280        | tt1229340          | nm0002071           | Ron Burgundy          |
      | nm0002071 | Will Ferrell | 395363        | tt1855401          | nm0002071           | Damien Weebs          |
      | nm0002071 | Will Ferrell | 362904        | tt1702425          | nm0002071           | Armando               |
      | nm0002071 | Will Ferrell | 374196        | tt1608290          | nm0002071           | Jacobim Mugatu        |
      | nm0002071 | Will Ferrell | 395745        | tt5657846          | nm0002071           | Brad                  |
      | nm0002071 | Will Ferrell | 392077        | tt1528854          | nm0002071           | Brad Whitaker         |
      | nm0002071 | Will Ferrell | 381045        | tt1001526          | nm0002071           | Megamind              |
      | nm0002071 | Will Ferrell | 406633        | tt1790886          | nm0002071           | Rep. Camden Cam Brady |
      | nm0002071 | Will Ferrell | 360499        | tt4481514          | nm0002071           | Scott Johansen        |
      | nm0002071 | Will Ferrell | 356323        | tt1255919          | nm0002071           | Sherlock Holmes       |
      | nm0002071 | Will Ferrell | 359370        | tt0457400          | nm0002071           | Dr. Rick Marshall     |
      | nm0002071 | Will Ferrell | 376367        | tt1386588          | nm0002071           | Allen Gamble          |
      | nm0002071 | Will Ferrell | 364708        | tt2561572          | nm0002071           | James                 |
      | nm0002071 | Will Ferrell | 396696        | tt1531663          | nm0002071           | Nick Halsey           |

  @HIGH @ps2
  Scenario Outline: #002 Ensure person API return available person (Brad Pitt) details by person ID
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_ID" : "<id>" parameter
    And service status code should return "200"
    And the response body should not be null
    Then Person ID: "<id>" should match with the response
    And Full Name: "<fullname>" should match with the response
    And characters ID: "<characters_id>" and Movie ID: "<characters_movieId>" and Person ID: "<characters_personId>" and "<characters_fullName>" should match with the response
    Examples:
      | id        | fullname  | characters_id | characters_movieId | characters_personId | characters_fullName |
      | nm0000093 | Brad Pitt | 388073        | tt1596363          | nm0000093           | Ben Rickert         |

  @HIGH @ps3
  Scenario Outline: #003 Ensure person API return available person details by person's Full Name
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_NAME" : "<fullname>" parameter
    And service status code should return "200"
    And the response body should not be null
    Then person ID "<id>" should match with the response person ID
    And person full Name "<fullname>" should match with the response person full name
    And response description should match with the expected "person_search_by_full_name" json file parameter: "description"
    And the expected characters ID: "<characters_id>" and Movie ID: "<characters_movieId>" and Person ID: "<characters_personId>" and "<characters_fullName>" should match with the response
    Examples:
      | id        | fullname   | characters_id | characters_movieId | characters_personId | characters_fullName |
      | nm0000226 | Will Smith | 379931        | tt1386697          | nm0000226           | Deadshot            |
      | nm0000226 | Will Smith | 348937        | tt1409024          | nm0000226           | Agent J             |
      | nm0000226 | Will Smith | 366413        | tt3322364          | nm0000226           | Dr. Bennet Omalu    |
      | nm0000226 | Will Smith | 348456        | tt1815862          | nm0000226           | Cypher Raige        |
      | nm0000226 | Will Smith | 361758        | tt2381941          | nm0000226           | Nicky               |

  @HIGH @ps4
  Scenario Outline: #004 SEARCH TERM <smith> should return all the available matching person ID and full name
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_SEARCH" : "<term>" parameter
    And service status code should return "200"
    And the response body should not be null
    And Search Term: "<term>" should match with the response ID: "<id>" and Full Name: "<fullName>"
    Examples:
      | term  | id        | fullName      |
      | smith | nm0807548 | Brooke Smith  |
      | smith | nm0005445 | Kerr Smith    |
      | smith | nm0807503 | Brandon Smith |
      | smith | nm1576004 | Akeem Smith   |

  @HIGH @ps5
  Scenario Outline: #005 SEARCH TERM "<will>" should not be case sensitive and should return available matching ID and Full Name
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_SEARCH" : "<term>" parameter
    And service status code should return "200"
    And the response body should not be null
    And Search Term: "<term>" should match with the response ID: "<id>" and Full Name: "<fullName>"
    Examples:
      | term | id        | fullName       |
      | will | nm4270089 | Sammy Williams |

  @HIGH @ps6
  Scenario Outline: #006 SEARCH TERM Letter case: "<Smith>" service GET call should be successful
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_SEARCH" : "<term>" parameter
    And service status code should return "200"
    And the response body should not be null
    And Search Term: "<term>" should match with the response ID: "<id>" and Full Name: "<fullName>"
    Examples:
      | term  | id        | fullName    |
      | Smith | nm0807548 | Brooke Smith |

  @HIGH @ps7
  Scenario Outline: #007 SEARCH CREW "<movie_id>" should return crew record
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_CREW" : "<movie_id>" parameter
    And service status code should return "200"
    And the response body should not be null
    And CREW ID: "<id>", Movie ID: "<movie_id>", Person ID: "<person_id>" and Person Type: "<person_type>"  should match with the response
    Examples:
      | id    | movie_id  | person_id | person_type     |
      | 46149 | tt1386697 | nm1664042 | cinematographer |

  @HIGH @ps8
  Scenario Outline: #008 SEARCH CHARACTERS "<movie_id>" should return characters record
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_CHARACTERS" : "<movie_id>" parameter
    And service status code should return "200"
    And the response body should not be null
    And CHARACTERS ID: "<id>", Movie ID: "<movie_id>", Person ID: "<person_id>" and Full Name: "<person_full_name>"  should match with the response
    Examples:
      | id     | movie_id  | person_id | person_full_name |
      | 368235 | tt1386697 | nm3053338 | Harley Quinn     |
      | 367566 | tt1598642 | nm3053338 | Ann Burden       |




