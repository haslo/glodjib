@visitor @admin
Feature: Login and logout work as expected
  In order to have a secure site
  as any user
  I want to be able to log in, log out, and have security for all parts of the application

  Background:
    Given I am not logged in

  Scenario: Open login page
    Given I am on the homepage
    And I have no posts
    When I follow the only "Login"
    Then I should see that "Login" is in a h2 tag
    And I should see "Email"
    And I should see "Password"

  Scenario: Log in on the login page
    Given I am on the homepage
    And I have no posts
    And there is an admin with "test@mail.com" and "password"
    When I follow the only "Login"
    And I fill in "Email" with "test@mail.com"
    And I fill in "Password" with "password"
    And I press "Login"
    Then I should see "test@mail.com"
    And I should see "Logged in successfully"
    And I should see "Logout"

  Scenario Outline: Check various pages for access denial with GET
    Given I am on the homepage
    And I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I try to visit the "<page_name>" page with method "<method>" and id "<id>"
    Then I should see "You need to log in or sign up before continuing"

  Examples:
    |page_name   |method|id|
    |posts       |get   |  |
    |new_post    |get   |  |
    |edit_post   |get   |X |

  Scenario Outline: Check various pages for access denial with DELETE
    Given I am on the homepage
    And I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I try to visit the "<page_name>" page with method "<method>" and id "<id>"
    Then I should see "You are being redirected"

  Examples:
    |page_name   |method|id|
    |destroy_post|delete|X |
    |reset_caches|delete|  |
