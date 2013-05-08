Given /^I have posts titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
    Post.create!(:title => title)
  end
end

Given /^I have no posts$/ do
  Post.delete_all
end

Given(/^I am on the list of posts$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I go to the list of posts$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I follow "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When(/^I press "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should have ([0-9]+) posts?$/ do |count|
  Post.count.should == count.to_i
end
