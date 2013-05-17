@visitor @issue4
Feature: Visit blog
  In order to obtain information and regular updates
  as a visitor
  I want to be able to navigate to the areas of the site that belong to the blog

  Background:
    Given I am not logged in

  Scenario: Check for comment links
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And my post titled Pizza has 2 comments
    And my post titled Breadsticks has 3 comments
    And I am on the homepage
    Then I should see "2 comments"
    And I should see "3 comments"

  Scenario: Check for comment form
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And my post titled Pizza has 2 comments
    And my post titled Breadsticks has 3 comments
    And I am on the homepage
    When I follow the only "Pizza"
    Then I should see "Leave a reply"
    And I should see "Name"
    And I should see "Email"
    And I should see "URL"
    And I should see "Comment"
    And I should see "Submit comment"

  Scenario: Post a comment
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And I am on the homepage
    When I follow the only "Pizza"
    And I fill in "Name" with "Some name"
    And I fill in "Comment" with "Some comment"
    And I press "Submit comment"
    Then I should have 1 comment
    And I should see "Some comment"

  Scenario: Post a comment with URL
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And I am on the homepage
    When I follow the only "Pizza"
    And I fill in "Name" with "Some name"
    And I fill in "URL" with "http://www.test.com"
    And I fill in "Comment" with "Some comment"
    And I press "Submit comment"
    Then I should have 1 comment
    And I should see that "Some name" links to "http://www.test.com"
    And I should see "Some comment"

  Scenario: Post the same comment twice
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And I am on the homepage
    When I follow the only "Pizza"
    And I fill in "Name" with "Some name"
    And I fill in "Comment" with "Some comment"
    And I press "Submit comment"
    And I fill in "Name" with "Some name"
    And I fill in "Comment" with "Some comment"
    And I press "Submit comment"
    Then I should have 1 comment
    And I should see "Error message from model here"