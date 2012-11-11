Feature: Play Games
  In order to play games
  As a participant in a game,
  I need to know when my action is required, and to be able to input my decisions

  Background: We need a pool of potential opponents, already signed up for the website
    Given these users:
    | name              |
    | test1@example.com |
    | test2@example.com |
    | test3@example.com |
    | test4@example.com |

  Scenario: Paticipant is shown notification when orders are due but (s)he hasn't yet entered them.
    Given I am signed in as "test2@example.com/test2@example.com"
    And I create a game named "Play_Game_Notify_Orders" with these players:
    | side        | name              |
    | Albatros    | test1@example.com |
    | Fokker      | test2@example.com |
    | Halberstadt | test3@example.com |
    When I go to the list of games
    Then I should see a notification on "Play_Game_Notify_Orders"


  Scenario: Participant can enter orders
    Given I am signed in as "test1@example.com/test1@example.com"
    And I create a game named "Play_Game_Enter_Orders" with these players:
    | side     | name              |
    | Albatros | test2@example.com |
    | Fokker   | test3@example.com |
    | Pfalz    | test1@example.com |
    When I am on the show game page
    And I set my orders to "Build" and "Research"
    Then I should see "Orders in game 'Play_Game_Enter_Orders' updated"
    And the game journal should contain "orders", "Pfalz", "Build", "Research"
    And I should not see a notification on "Play_Game_Enter_Orders"
