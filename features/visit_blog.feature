@visitor
Feature: Visit blog
  In order to obtain information and regular updates
  as a visitor
  I want to be able to navigate to the areas of the site that belong to the blog

  Scenario: Check for title link
    Given I have no posts
    And I am on the homepage
    When I follow the page title link
    Then I should see the page title as "Blog - Guido Gloor Modjib Photography"
    And I should see that "Blog" is in a h2 tag

  Scenario: View posts list on homepage
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I go to the homepage
    Then I should see "Pizza"
    And I should see "Breadsticks"
    And I should see "Dummy Text"

  Scenario: View post
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I go to the homepage
    And I follow the only "Pizza"
    Then I should see that "Pizza" is in a h2 tag
    And I should see "Dummy Text"

  Scenario: Observe post with "Read more..." link in posts list
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text!!more!!totally hidden text"
    When I go to the homepage
    Then I should see "Pizza"
    And I should see "Breadsticks"
    And I should see "Dummy Text"
    And I should see "Read more..."
    And I should not see "!!more!!"
    And I should not see "totally hidden text"

  Scenario: View post with "Read more..." link
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text!!more!!totally hidden text"
    When I go to the homepage
    And I follow the only "Pizza"
    Then I should see that "Pizza" is in a h2 tag
    And I should see "Dummy Text"
    And I should not see "Read more..."
    And I should not see "!!more!!"
    And I should see "totally hidden text"

  Scenario: View several blog posts by common tag
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And my "Pizza" post has the tags pizza, cheese, yummie
    And my "Breadsticks" post has the tags bread, yummie
    When I follow the first "yummie"
    Then I should see "Pizza"
    And I should see "Breadsticks"

  Scenario: View only some blog posts by distinct tag
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    And my "Pizza" post has the tags pizza, cheese, yummie
    And my "Breadsticks" post has the tags bread, yummie
    When I follow the first "cheese"
    Then I should see "Pizza"
    And I should not see "Breadsticks"
