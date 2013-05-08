Feature: Manage Posts
  In order to make a blog
  As an author
  I want to create and manage posts

  Scenario: Posts List
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I go to the homepage
    Then I should see "Pizza"
    And I should see "Breadsticks"
    And I should see "Dummy Text"

  Scenario: Create Valid Post
    Given I have no posts
    And I am on the homepage
    When I follow "New Post"
    And I fill in "Title" with "Spuds"
    And I fill in "Content" with "Delicious potato wedges!"
    And I press "Create Post"
    Then I should see "New post created"
    And I should see "Spuds"
    And I should see "Delicious potato wedges!"
    And I should have 1 post

  Scenario: Create Invalid Post
    Given I have no posts
    And I am on the homepage
    When I follow "New Post"
    And I press "Create Post"
    Then I should see "Invalid post"
    And I should see "Title can't be blank"
    And I should see "Content can't be blank"
    And I should see 2 field error messages
    And I should have 0 posts