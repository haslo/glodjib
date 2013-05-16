Given(/^I am on the homepage$/) do
  visit root_path
end

When(/^I go to the homepage$/) do
  visit root_path
end

When(/^I try to visit the "(.*?)" page with method "(.*?)" and id "(.*?)"$/) do |page_name, method, id|
  case method.downcase.strip
    when "get"
      if id.nil?
        eval "visit #{page_name}_path"
      else
        eval "visit #{page_name}_path(:id => '#{id}')"
      end
    when "delete"
      if id.nil?
        eval "Capybara.current_session.driver.delete #{page_name}_path"
      else
        eval "Capybara.current_session.driver.delete #{page_name}_path(:id => '#{id}')"
      end
    else
      pending "method #{method} not implemented yet"
  end
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
