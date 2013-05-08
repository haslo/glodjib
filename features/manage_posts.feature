Feature: Manage Posts
  In order to make a blog
  As an author
  I want to create and manage posts

  Scenario: Posts List
    Given I have posts titled Pizza, Breadsticks
    When I go to the homepage
    Then I should see "Pizza"
    And I should see "Breadsticks"

  Scenario: Create Valid Article
    Given I have no posts
    And I am on the homepage
    When I follow "New Post"
    And I fill in "Title" with "Spuds"
    And I fill in "Content" with "Delicious potato wedges!"
    And I press "Create"
    Then I should see "New post created."
    And I should see "Spuds"
    And I should see "Delicious potato wedges!"
    And I should have 1 post