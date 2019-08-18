@retropaper_movie_API
Feature: Dossier: Create new dossier
  Dossier API will ensure endpoints are healthy and return expected results.
  Scopes:
    1. All Dossiers : /api/v1/dossier/all
    2. Create New Dossier : POST /api/v1/dossier have to pass JSON structure of dossier
    3. My Dossiers : /api/v1/dossier/my returns dossiers of reviewer
    4. Dossier By Id : /api/v1/dossier/{id}
    5. Update Dossier : PUT /api/v1/dossier/{id}/update updates a dossier

  Scenario: #001 Ensure retropaper movie API return single all movie details
    Given "MOVIE_API" service endpoint: "MOVIE" is called with "all" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "MOVIE_API" service should return all movie details

  Scenario: #002 Ensure retropaper movie API return 400 status code for bad request
    Given "MOVIE_API" service endpoint: "MOVIE" is called with "all" parameter
    And service status code should return "400"

