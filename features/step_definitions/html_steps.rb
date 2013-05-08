Then(/^I should see the page title as "(.*?)"$/) do |title|
  assert_equal title, page.find(:css, 'title').text
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
