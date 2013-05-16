Given(/^I am logged in as an admin$/) do
  User.create!(:email => "test@mail.com", :password => 'password', :password_confirmation => 'password')
  visit new_user_session_path
  fill_in "Email", :with => "test@mail.com"
  fill_in "Password", :with => 'password'
  click_button "Login"
end

Given(/^there is an admin with "(.*?)" and "(.*?)"$/) do |email, password|
  User.create!(:email => email, :password => password, :password_confirmation => password)
end

Given(/^I am not logged in$/) do
  # nothing to do
end