@admin @issue23
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
    Then I should see "Admin"

  Scenario Outline: Open settings page and check for fields
    Given I am on the homepage
    And I follow the only "Admin"
    Then I should see the setting translation for "<fieldname>"

  Examples:
    |fieldname                  |
    |flickr_api_key             |
    |flickr_shared_secret       |
    |page_title                 |
    |post_more_separator        |
    |admin_password             |
    |admin_password_confirmation|

  Scenario: Update settings
    Given I am on the homepage
    And I follow the only "Admin"
    When I fill in "Flickr API key" with "1234"
    And I fill in "Flickr shared secret" with "5678"
    And I fill in "Page title" with "9012"
    And I fill in "Separator" with "3456"
    And I press "Save settings"
    Then my settings should be as follows:
      |fieldname                  |value|
      |flickr_api_key             |1234 |
      |flickr_shared_secret       |5678 |
      |page_title                 |9012 |
      |post_more_separator        |3456 |
