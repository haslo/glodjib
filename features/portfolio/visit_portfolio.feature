@visitor @flickr_api
Feature: Visit portfolio
  In order to view images and obtain information about them
  as a visitor
  I want to be able to navigate to the areas of the site that belong to the portfolio

  Background:
    Given I am not logged in

  Scenario: Visit portfolio
    Given I have no posts
    And I am on the homepage
    When I follow the only "Portfolio"
    Then I should see the page title as "Portfolio - the glodjib platform"
    And I should see that "Portfolio" is in a h2 tag
    And I should see at least 1 portfolio image thumbnail

  Scenario: No management functionality is exposed on the portfolio page
    Given I have no posts
    And I am on the homepage
    When I follow the only "Portfolio"
    Then I should not see "Reset Caches"
