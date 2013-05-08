Given /^I have posts titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
    Post.create!(:title => title)
  end
end

Given /^I have no posts$/ do
  Post.delete_all
end

Given(/^I am on the homepage$/) do
  visit root_path
end

When(/^I go to the homepage$/) do
  visit root_path
end

When(/^I follow "(.*?)"$/) do |link_text|
  click_link link_text
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field_name, field_text|
  pending # express the regexp above with the code you wish you had
end

When(/^I press "(.*?)"$/) do |button_text|
  click_button button_text
end

Then(/^I should see "(.*?)"$/) do |message|
  page.should have_text(message)
end

Then /^I should have ([0-9]+) posts?$/ do |count|
  Post.count.should == count.to_i
end
