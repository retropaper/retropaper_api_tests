Feature: BDSO API: User Search

  @HIGH @us1
  Scenario Outline: #001 Ensure BDSO GATEWAY API return single user details by user ID
    Given "BDSO_GATEWAY" api service endpoint is called with "USERS" endpoint and "<user_id>" parameter
    And service status code should return "200"
    And the response body should not be null
    Then "BDSO_GATEWAY" api service should return following users details
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
      | user_id |
      | jdoe    |





#  getUserByUserId
#
#  localhost:8090/api/users/userid





#
#  {
#  "id": 1,
#  "createdBy": "Temp Test",
#  "createdDate": 1562943215.703,
#  "lastModifiedBy": "Temp Test",
#  "lastModifiedDate": 1562943215.703,
#  "firstName": "John",
#  "lastName": "Doe",
#  "dob": "12/32/1989",
#  "userId": "jdoe"
#  }



#  switch out userId with the specific id.  Right now returns a default test user
#
#  getAllUsers
#
#  localhost:8090/api/users/all
#
#  returns a list of all users.  Right now returns a list of test users
#
#
#
#  getUser
#
#  localhost:8090/api/users/me
#
#  returns the current logged in user.  Right now returns a default test user