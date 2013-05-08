Feature: Basic Visitor Functionality
  In order to obtain information
  As a visitor
  I want to be able to navigate to the areas of the site

  Scenario: Check for Title Link
    Given I have no posts
    And I am on the homepage
    When I follow the page title link
    Then I should see the page title as "glodjib.ch - Guido Gloor Modjib Photography"
    And I should see that "Blog" is in a h2 tag

  Scenario: Posts List
    Given I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I go to the homepage
    Then I should see "Pizza"
    And I should see "Breadsticks"
    And I should see "Dummy Text"

  Scenario: Visit Portfolio
    Given I have no posts
    And I am on the homepage
    When I follow "Portfolio"
    Then I should see the page title as "Portfolio - Guido Gloor Modjib Photography"
    And I should see that "Portfolio" is in a h2 tag