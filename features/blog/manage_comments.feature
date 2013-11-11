@admin @issue29
Feature: Visit blog
  In order to obtain information and regular updates
  as a visitor
  I want to be able to navigate to the areas of the site that belong to the blog

  Background:
    Given I am logged in as an admin
    And Settings are present

  Scenario: Check for comment management links
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And my post titled Pizza has 2 comments
    And my post titled Breadsticks has 3 comments
    And I am on the homepage
    When I follow the only "Pizza"
    Then I should see "Spam Comment"
    And I should see "Delete Comment"

  Scenario: Spam comment
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And my post titled Pizza has 1 comment
    And I am on the homepage
    When I follow the first "Pizza"
    And I follow the first "Spam Comment"
    Then I should have 0 ham comments
    And I should have 1 spam comment

  Scenario: Delete comment
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And my post titled Pizza has 1 comment
    And I am on the homepage
    When I follow the first "Pizza"
    And I follow the first "Delete Comment"
    Then I should have 0 ham comments
    And I should have 1 deleted comment
