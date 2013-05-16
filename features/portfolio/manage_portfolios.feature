@admin @flickr_api
Feature: Manage portfolios
  In order to make the portfolio part useful and informative
  as an admin
  I want to manage images in my portfolio

  Scenario: Reset portfolio caches
    Given I have no posts
    And I have at least 2 cache entries
    And I am on the homepage
    When I follow the only "Portfolio"
    And I follow the only "Reset Caches"
    Then there should be exactly 1 cache entries
    And I should see "Flickr image cache updated"
