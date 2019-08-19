@PERSON_API
Feature: Person API: Search for person
  Person API will ensure endpoints are healthy and return expected results.
  Scopes:
  1. All persons : /api/v1/person/all
  2. Person by Id : /api/v1/person/{id} id = nm0002071
  3. People by Name : /api/v1/person/name/{name}
  4. Search People : /api/v1/person/search?term={term}

  @HIGH1 @ps1
  Scenario Outline: #001 Ensure person API return available person details by person ID
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_ID" : "<id>" parameter
    And service status code should return "200"
    And the response body should not be null
    Then Person ID: "<id>" should match with the response
    And Full Name: "<fullname>" should match with the response
    And characters ID: "<characters_id>" and Movie ID: "<characters_movieId>" and Person ID: "<characters_personId>" and "<characters_fullName>" should match with the response
    Examples:
      | id        | fullname     | characters_id | characters_movieId | characters_personId | characters_fullName                                 |
      | nm0002071 | Will Ferrell | 182468        | tt1255919          | nm0002071           | Sherlock Holmes                                     |
      | nm0002071 | Will Ferrell | 157844        | tt2561572          | nm0002071           | James                                               |
      | nm0002071 | Will Ferrell | 185510        | tt1001526          | nm0002071           | Megamind                                            |
      | nm0002071 | Will Ferrell | 166499        | tt1702425          | nm0002071           | Armando                                             |
      | nm0002071 | Will Ferrell | 187487        | tt1386588          | nm0002071           | Allen Gamble                                        |
      | nm0002071 | Will Ferrell | 190342        | tt1528854          | nm0002071           | Brad Whitaker                                       |
      | nm0002071 | Will Ferrell | 215899        | tt1790886          | nm0002071           | Rep. Camden Cam Brady                               |
      | nm0002071 | Will Ferrell | 198186        | tt5657846          | nm0002071           | Brad                                                |
      | nm0002071 | Will Ferrell | 180689        | tt1490017          | nm0002071           | Lord Business, President Business, The Man Upstairs |
      | nm0002071 | Will Ferrell | 175249        | tt4481514          | nm0002071           | Scott Johansen                                      |
      | nm0002071 | Will Ferrell | 166015        | tt0457400          | nm0002071           | Dr. Rick Marshall                                   |
      | nm0002071 | Will Ferrell | 179130        | tt1608290          | nm0002071           | Jacobim Mugatu                                      |
      | nm0002071 | Will Ferrell | 200782        | tt1531663          | nm0002071           | Nick Halsey                                         |
      | nm0002071 | Will Ferrell | 194235        | tt1229340          | nm0002071           | Ron Burgundy                                        |
      | nm0002071 | Will Ferrell | 196240        | tt1855401          | nm0002071           | Damien Weebs                                        |

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
      | nm0000093 | Brad Pitt | 243082        | tt1764234          | nm0000093           | Jackie         |

  @HIGH1 @ps3
  Scenario Outline: #003 Ensure person API return available person details by person's Full Name
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_NAME" : "<fullname>" parameter
    And service status code should return "200"
    And the response body should not be null
    Then person ID "<id>" should match with the response person ID
    And person full Name "<fullname>" should match with the response person full name
    And expected "person_search_by_full_name" json file should match with the response
    Examples:
      | id        | fullname  |
      | nm0000093 | Brad Pitt |


  @HIGH1 @ps4a
  Scenario: #004 Ensure person API return available user or person details by person name
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_NAME" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "PERSON_API" service should return all user details

  @HIGH1 @ps4
  Scenario: #004 Ensure person API return available user or person details by person term
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_ALL" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "PERSON_API" service should return all user details

  @HIGH1 @ps5
  Scenario: #005 Ensure retropaper person API return 400 status code for bad request
    Given "PERSON_API" service endpoint: "PERSON" is called with "all" parameter
    And service status code should return "400"


  @HIGH1 @ps6
  Scenario: #002 Ensure person API return all available user or person details
    Given "GET" service "PERSON_API" endpoint: "PERSON" is called with "PERSON_ALL" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "PERSON_API" service should return all user details