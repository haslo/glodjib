@visitor @issue4
Feature: Visit blog
  In order to obtain information and regular updates
  as a visitor
  I want to be able to navigate to the areas of the site that belong to the blog

  Background:
    Given I am not logged in

  Scenario: Check for comment links
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And my post titled Pizza has 1 comment
    And my post titled Breadsticks has 3 comments
    And I am on the homepage
    Then I should see "1 comment"
    And I should see "3 comments"
    And I should not see "1 comments"
    And I should see that there is a link that says "3 comments"

  Scenario: Check for comment form
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And my post titled Pizza has 1 comment
    And my post titled Breadsticks has 3 comments
    And I am on the homepage
    When I follow the only "Pizza"
    Then I should see "Leave a reply"
    And I should see "Name"
    And I should see "Email"
    And I should see "URL"
    And I should see "Comment"

  Scenario: Post a comment
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And I am on the homepage
    When I follow the only "Pizza"
    And I fill in "Name" with "Some name"
    And I fill in "Comment" with "Some comment"
    And I press "Submit Comment"
    Then I should have 1 comment
    And I should see "1 comment"
    And I should not see "1 comments"
    And I should see "Some name"
    And I should see "Some comment"

  Scenario: Post a comment with URL
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And I am on the homepage
    When I follow the only "Pizza"
    And I fill in "Name" with "Some name"
    And I fill in "URL" with "http://www.test.com"
    And I fill in "Comment" with "Some comment"
    And I press "Submit Comment"
    Then I should have 1 comment
    And I should see that "Some name" links to "http://www.test.com"
    And I should see "Some comment"

  Scenario: Post the same comment twice
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And I am on the homepage
    When I follow the only "Pizza"
    And I fill in "Name" with "Some name"
    And I fill in "Comment" with "Some comment"
    And I press "Submit Comment"
    And I fill in "Name" with "Some name"
    And I fill in "Comment" with "Some comment"
    And I press "Submit Comment"
    Then I should have 1 comment
    And I should see "Duplicate comments are not allowed"
