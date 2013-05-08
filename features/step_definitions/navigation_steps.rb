Given(/^I am on the homepage$/) do
  visit root_path
end

When(/^I go to the homepage$/) do
  visit root_path
end

When(/^I follow the title link$/) do
  find("h1:first a").click
end

When(/^I follow "(.*?)"$/) do |link_text|
  click_link link_text
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field_name, field_text|
  fill_in field_name, :with => field_text
end

When(/^I press "(.*?)"$/) do |button_text|
  click_button button_text
end
