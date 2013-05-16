@admin @flickr_api
Feature: Manage portfolios
  In order to make the portfolio part useful and informative
  as an admin
  I want to manage images in my portfolio

  Background:
    Given I am logged in as an admin

  Scenario: Reset portfolio caches
    Given I am on the homepage
    And I have no posts
    And I have at least 2 Flickr cache entries
    When I follow the only "Portfolio"
    And I follow the only "Reset Caches"
    Then there should be exactly 1 Flickr cache entries
    And I should see "Flickr image cache updated"
