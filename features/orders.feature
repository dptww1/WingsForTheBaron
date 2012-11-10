Feature: Orders
  In order to
  As a player in a game
  I need to enter and change orders for the current turn

  Background: We need a pool of potential opponents, already signed up for the website
    Given these users:
    | name              |
    | test1@example.com |
    | test2@example.com |
    | test3@example.com |
    | test4@example.com |

  Scenario: Games list should show notification when the

  Scenario: Participant can enter orders
    Given I am signed in as "test1@example.com/test1@example.com"
    And I create a game named "Orders1" with these players:
    | side     | name              |
    | Albatros | test2@example.com |
    | Fokker   | test3@example.com |
    | Pfalz    | test1@example.com |
    When I am on the show game page
    And I set my orders to "Build" and "Research"
    Then I should see "Orders in game 'Orders1' updated"
    And the game journal should contain "orders", "Pfalz", "Build", "Research"

