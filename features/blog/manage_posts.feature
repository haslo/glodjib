@admin
Feature: Manage Posts
  In order to provide information to the visitors with a blog
  as an admin
  I want to create and manage posts

  Scenario: Open new post form
    Given I have no posts
    And I am on the homepage
    When I follow the only "New Post"
    Then I should see that "New Blog Post" is in a h2 tag
    And I should see "Title"
    And I should see "Content"

  Scenario: Create valid post
    Given I have no posts
    And I am on the homepage
    When I follow the only "New Post"
    And I fill in "Title" with "Spuds"
    And I fill in "Content" with "Delicious potato wedges!"
    And I press "Create Post"
    Then I should see "New post created"
    And I should see "Spuds"
    And I should see that "Spuds" is in a h3 tag
    And I should see "Delicious potato wedges!"
    And I should have 1 post

  Scenario: Attempt to create invalid post
    Given I have no posts
    And I am on the homepage
    When I follow the only "New Post"
    And I press "Create Post"
    Then I should see "Invalid post"
    And I should see "Title can't be blank"
    And I should see "Content can't be blank"
    And I should see 2 field error messages
    And I should have 0 posts

  Scenario: Edit post
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I go to the homepage
    And I follow the first "Edit Post"
    And I fill in "Title" with "Potatoes"
    And I fill in "Content" with "Rather awesome dog sauce"
    And I press "Update Post"
    Then I should see "Post updated"
    And I should see "Potatoes"
    And I should see that "Potatoes" is in a h3 tag
    And I should see "Rather awesome dog sauce"
    And I should have 2 posts

  Scenario: Delete post
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I go to the homepage
    And I follow the first "Delete Post"
    Then I should not see that "Pizza" is in a h3 tag
    And I should see that "Breadsticks" is in a h3 tag

  Scenario: Add tag to post in edit
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I go to the homepage
    And I follow the first "Edit Post"
    And I fill in "Tags" with "pizza, cheese, yummie"
    And I press "Update Post"
    Then I should see "Post updated"
    And I should see "pizza"
    And I should see "cheese"
    And I should see "yummie"
    And I should have 2 posts
    And I should have 3 post tags
