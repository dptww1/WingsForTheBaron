Feature: Manage Games
  In order to play games 
  As a user
  I want to view, create and delete games

  Scenario: Games List
    Given I have games named "One", "Two", "Three"
    When I go to the list of games
    Then I should see "One"
     And I should see "Two"
     And I should see "Three"

  Scenario: Anonymous User cannot create a game
    Given I am not signed in
    When I go to the list of games
    Then I should not see "Create New Game"

  Scenario: Signed-in user has option to create a game
    Given I am signed in
    When I go to the list of games
    Then I should see "Create New Game"
    
  Scenario: Signed-in user can create game with four players
    Given I am signed in
    When I create a game named "Test4a" with players Albatros, Fokker, Halberstadt, Pfalz
    Then I should be on the show game page
     And I should see "Test4"
     And I should see "Albatros"
     And I should see "Fokker"
     And I should see "Halberstadt"
     And I should see "Pfalz"

  Scenario: Signed-in user can create game with three players
    Given I am signed in
    When I create a game named "Test4a" with players Albatros, Fokker, Halberstadt
    Then I should be on the show game page
     And I should see "Test4"
     And I should see "Albatros"
     And I should see "Fokker"
     And I should see "Halberstadt"
     And I should not see "Pfalz"
