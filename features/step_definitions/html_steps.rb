Then(/^I should see the page title as "(.*?)"$/) do |title|
  page.should have_title(title)
end

Then(/^I should see "(.*?)"$/) do |message|
  page.should have_text(message)
end

Then(/^I should see that "(.*?)" is in a (.*?) tag/) do |text, tag|
  page.should have_selector(tag, :text => text)
end

Then(/^I should not see that "(.*?)" is in a (.*?) tag/) do |text, tag|
  page.should_not have_selector(tag, :text => text)
end

Then(/^I should see ([0-9]+) field error messages$/) do |message_count|
  page.should have_selector('.field_error', :count => message_count)
end
