Feature: Manage Games
  In order to play games
  As a user
  I want to view, create and delete games

  Background: We need a pool of potential opponents, already signed up for the website
    Given these users:
    | name              |
    | test1@example.com |
    | test2@example.com |
    | test3@example.com |
    | test4@example.com |

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
    Given I am signed in as "test1@example.com/test1@example.com"
    When I create a game named "Test4a" with these players:
    | side        | name              |
    | Albatros    | test2@example.com |
    | Fokker      | test3@example.com |
    | Halberstadt | test4@example.com |
    | Pfalz       | test1@example.com |
    Then I should be on the show game page
     And I should see "Test4"
     And I should see "Albatros"
     And I should see "Fokker"
     And I should see "Halberstadt"
     And I should see "Pfalz"

  Scenario: Signed-in user can create game with three players
    Given I am signed in
    When I create a game named "Test4b" with these players:
    | side     | name              |
    | Albatros | test3@example.com |
    | Fokker   | test1@example.com |
    | Pfalz    | test2@example.com |
    Then I should be on the show game page
     And I should see "Test4"
     And I should see "Albatros"
     And I should see "Fokker"
     And I should not see "Halberstadt"
     And I should see "Pfalz"

  Scenario: Game owner can edit players
    Given I am signed in
    And I create a game named "Test3" with these players:
    | side     | name              |
    | Albatros | test3@example.com |
    | Fokker   | test1@example.com |
    | Pfalz    | test2@example.com |
    When I update the game with these players:
    | side     | name              |
    | Albatros | test2@example.com  |
    | Pfalz    | test3@example.com  |
    Then I should be on the show game page
    And I should see "Albatros (test2@example.com)"
    And I should see "Fokker (test1@example.com)"
    And I should see "Pfalz (test3@example.com)"
