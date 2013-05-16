Given(/^I am logged in as an admin$/) do
  user = User.create!(:email => "test@mail.com", :password => 'password', :password_confirmation => 'password')
  visit login_path
  fill_in "Email", :with => "test@mail.com"
  fill_in "Password", :with => 'password'
  click_button "Login"
end

Given(/^I am not logged in$/) do
  # nothing to do
end