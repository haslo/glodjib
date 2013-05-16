Given(/^I am on the homepage$/) do
  visit root_path
end

When(/^I go to the homepage$/) do
  visit root_path
end

When(/^I try to visit the "new_post" page$/) do
  visit new_post_path(:format => :html)
end

When(/^I follow the main title link$/) do
  find("h1:first a").click
end

When(/^I follow the page title link$/) do
  find("h2:first a").click
end

When(/^I follow the first "(.*?)"$/) do |link_text|
  first(:link, link_text).click
end

When(/^I follow the only "(.*?)"$/) do |link_text|
  click_link link_text
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field_name, field_text|
  fill_in field_name, :with => field_text
end

When(/^I press "(.*?)"$/) do |button_text|
  click_button button_text
end
