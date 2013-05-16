@admin
Feature: Manage the site as a whole
  In order to configure the site as a whole
  as an admin
  I want to set parameters for the site

  Background:
    Given I am logged in as an admin

  Scenario: Log out as an admin
    Given I am on the homepage
    And I follow the only "Logout"
    Then I should not see "test@mail.com"
    And I should see "Logged out successfully"
    And I should see "Login"

  Scenario: Observe settings link
    Given I am on the homepage
    Then I should see "Settings"

  Scenario Scenario Outline: Open settings page and check for fields
    Given I am on the homepage
    And I follow the only "Settings"
    Then I should see "Flickr username"
    And I should see "Flickr API key"
    And I should see "Flickr shared secret"
    And I should see "Page title"
    And I should see "Admin password"
    And I should see "Admin password confirmation"