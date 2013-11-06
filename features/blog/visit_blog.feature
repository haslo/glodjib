@visitor
Feature: Visit blog
  In order to obtain information and regular updates
  as a visitor
  I want to be able to navigate to the areas of the site that belong to the blog

  Background:
    Given I am not logged in

  Scenario: Check for title link
    Given I have no posts
    And I am on the homepage
    When I follow the page title link
    Then I should see the page title as "Blog - the glodjib platform"
    And I should see that "Blog" is in a h2 tag

  Scenario: View posts list on homepage
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And I am on the homepage
    Then I should see "Pizza"
    And I should see "Breadsticks"
    And I should see "Dummy Text"
    And I should see that there is a link that says "Be the first to comment!"

  Scenario: View post
    Given I am on the homepage
    And I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And I am on the homepage
    When I follow the only "Pizza"
    Then I should see that "Pizza" is in a h2 tag
    And I should see "Dummy Text"

  Scenario: Observe post with "Read more..." link in posts list
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text!!more!!totally hidden text"
    And I am on the homepage
    Then I should see "Pizza"
    And I should see "Breadsticks"
    And I should see "Dummy Text"
    And I should see "Read More..."
    And I should not see "!!more!!"
    And I should not see "totally hidden text"

  Scenario: View post with "Read more..." link
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text!!more!!totally hidden text"
    And I am on the homepage
    When I follow the only "Pizza"
    Then I should see that "Pizza" is in a h2 tag
    And I should see "Dummy Text"
    And I should not see "Read more..."
    And I should not see "!!more!!"
    And I should see "totally hidden text"

  Scenario: Observe presence of tags title when there is a post with tags
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And my "Pizza" post has the tags pizza, cheese, yummie
    And I am on the homepage
    Then I should see "Tags:"

  Scenario: Observe absence of tags title when there is no post with tags
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And I am on the homepage
    Then I should not see "Tags:"

  Scenario: View several blog posts by common tag
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And my "Pizza" post has the tags pizza, cheese, yummie
    And my "Breadsticks" post has the tags bread, yummie
    And I am on the homepage
    When I follow the first "yummie"
    Then I should see "Pizza"
    And I should see "Breadsticks"

  Scenario: View only some blog posts by distinct tag
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And my "Pizza" post has the tags pizza, cheese, yummie
    And my "Breadsticks" post has the tags bread, yummie
    And I am on the homepage
    When I follow the first "cheese"
    Then I should see "Pizza"
    And I should not see "Breadsticks"

  Scenario: No management functionality is exposed on the front page
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And I am on the homepage
    Then I should not see "Edit Post"
    And I should not see "Delete Post"
    And I should not see "New Post"

  Scenario: Check footer for copyright information
    Given I am on the homepage
    Then I should see "©"
    And I should see "glodjib platform"
