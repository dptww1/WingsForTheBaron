Feature: Manage Games
  In order to play games 
  As a user
  I want to create and delete games

  Scenario: Games List
    Given I have games named One, Two, Three
    When I go to the list of games
    Then I should see "One"
     And I should see "Two"
     And I should see "Three"
    
