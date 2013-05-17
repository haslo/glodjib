@admin @issue4
Feature: Visit blog
  In order to obtain information and regular updates
  as a visitor
  I want to be able to navigate to the areas of the site that belong to the blog

  Background:
    Given I am logged in as an admin

  Scenario: Check for comment management links
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And my post titled Pizza has 2 comments
    And my post titled Breadsticks has 3 comments
    And I am on the homepage
    When I follow the only "Pizza"
    Then I should see "Spam comment"
    And I should see "Delete comment"
