Given /^I have posts titled (.+) that say "(.+)"$/ do |titles, content|
  titles.split(', ').each do |title|
    Post.create!(:title => title, :content => content)
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
  fill_in field_name, :with => field_text
end

When(/^I press "(.*?)"$/) do |button_text|
  click_button button_text
end

Then(/^I should see "(.*?)"$/) do |message|
  page.should have_text(message)
end

Then(/^I should see that "(.*?)" is in a (.*?) tag/) do |text, tag|
  page.should have_selector(tag, :text => text)
end
Then(/^I should see ([0-9]+) field error messages$/) do |message_count|
  page.should have_selector('.field_error', :count => message_count)
end

Then /^I should have ([0-9]+) posts?$/ do |count|
  Post.count.should == count.to_i
end
