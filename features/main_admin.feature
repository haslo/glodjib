@admin
Feature: Manage the site as a whole
  In order to configure the site as a whole
  as an admin
  I want to set parameters for the site

  Background:
    Given I am not logged in

  Scenario: Open login page
    Given I am on the homepage
    And I have no posts
    When I follow the only "Login"
    Then I should see that "Login" is in a h2 tag
    And I should see "Email"
    And I should see "Password"

  Scenario: Log in on the login page
    Given I am on the homepage
    And I have no posts
    And there is an admin with "test@mail.com" and "password"
    When I follow the only "Login"
    And I fill in "Email" with "test@mail.com"
    And I fill in "Password" with "password"
    And I press "Login"
    Then I should see "test@mail.com"
    And I should see "Logged in successfully"
    And I should see "Logout"

  Scenario: Log out after being logged in
    Given I am on the homepage
    And I am logged in as an admin
    And I follow the only "Logout"
    Then I should not see "test@mail.com"
    And I should see "Logged out successfully"
    And I should see "Login"

  Scenario: Check new post page for access denial
    Given I am on the homepage
    And I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I try to visit the "new_post" page
    Then I should see "You need to log in or sign up before continuing"
