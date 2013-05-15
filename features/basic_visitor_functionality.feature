Feature: Basic Visitor Functionality
  In order to obtain information
  As a visitor
  I want to be able to navigate to the areas of the site

  Scenario: Check for Title Link
    Given I have no posts
    And I am on the homepage
    When I follow the page title link
    Then I should see the page title as "Blog - Guido Gloor Modjib Photography"
    And I should see that "Blog" is in a h2 tag

  Scenario: Posts List
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I go to the homepage
    Then I should see "Pizza"
    And I should see "Breadsticks"
    And I should see "Dummy Text"

  Scenario: View Post
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I go to the homepage
    And I follow the only "Pizza"
    Then I should see that "Pizza" is in a h2 tag
    And I should see "Dummy Text"

  Scenario: Post With "Read More" Link in Posts List
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text!!more!!totally hidden text"
    When I go to the homepage
    Then I should see "Pizza"
    And I should see "Breadsticks"
    And I should see "Dummy Text"
    And I should not see "!!more!!"
    And I should not see "totally hidden text"

  Scenario: View Post With "Read More" Link
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text!!more!!totally hidden text"
    When I go to the homepage
    And I follow the only "Pizza"
    Then I should see that "Pizza" is in a h2 tag
    And I should see "Dummy Text"
    And I should not see "!!more!!"
    And I should see "totally hidden text"

  @flickr_api
  Scenario: Visit Portfolio
    Given I have no posts
    And I am on the homepage
    When I follow the only "Portfolio"
    Then I should see the page title as "Portfolio - Guido Gloor Modjib Photography"
    And I should see that "Portfolio" is in a h2 tag
    And I should see at least 1 portfolio image thumbnail
