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
    And I should see "Username"
    And I should see "Password"

  Scenario: Log in on the login page
    Given I am on the homepage
    And I have no posts
    When I follow the only "Login"
    And I fill in "Username" with "admin"
    And I fill in "Password" with "password"
    And I press "Login"
    Then I should see "Welcome, admin"
    And I should see "Logout"
