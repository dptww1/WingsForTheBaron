Feature: Manage Users
  In order to manage my access to the website
  As a web user
  I want to register, sign in, and sign out

  Scenario: Registration
    Given I am not signed in
    When I register as "test999@example.com/test999@example.com"
    Then I should see "signed up successfully"
