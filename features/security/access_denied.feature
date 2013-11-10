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
    When I follow the only "login"
    Then I should see that "Login" is in a h2 tag
    And I should see "Email"
    And I should see "Password"

  Scenario: Log in on the login page
    Given I am on the homepage
    And I have no posts
    And there is an admin with "test@mail.com" and "password"
    When I follow the only "login"
    And I fill in "Email" with "test@mail.com"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Logged in successfully"
    And I should see "logout"

  Scenario Outline: Check various pages for access denial with GET
    Given I am on the homepage
    And I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I try to visit the "<page_name>" page with method "<method>" and id "<id>"
    Then I should see "You need to log in or sign up before continuing"

  Examples:
    |page_name   |method|id|
    |new_post    |get   |  |
    |edit_post   |get   |X |

  Scenario Outline: Check various pages for access denial with DELETE
    Given I am on the homepage
    And I have posts titled Pizza, Breadsticks that say "Dummy Text"
    When I try to visit the "<page_name>" page with method "<method>" and id "<id>"
    Then I should see "You are being redirected"

  Examples:
    |page_name                 |method|id|
    |post                      |delete|X |
    |reset_caches_flickr_images|delete|X |
