Given(/^I am logged in as an admin$/) do
  user = User.create!(:username => 'admin', :password => 'password', :password_confirmation => 'password')
  visit login_path
  fill_in "Username", :with => user.username
  fill_in "Password", :with => 'password'
  click_button "Login"
end

Given(/^I am not logged in$/) do
  # nothing to do
end