Feature: Manage Games
  In order to play games 
  As a user
  I want to view, create and delete games

  Scenario: Games List
    Given I have games named One, Two, Three
    When I go to the list of games
    Then I should see "One"
     And I should see "Two"
     And I should see "Three"

  Scenario: Anonymous User cannot create a game
    Given I am not signed in
    When I go to the list of games
    Then I should not see "Create New Game"

  Scenario: Signed-in user can create a game
    Given I am signed in as "test123@example.com/test123"
    When I go to the list of games
    Then I should see "Create New Game"
    
