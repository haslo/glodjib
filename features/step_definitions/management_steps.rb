Given(/^I am logged in as an admin$/) do
  User.create!(:email => "test@mail.com", :password => 'password', :password_confirmation => 'password')
  visit new_user_session_path
  fill_in "Email", :with => "test@mail.com"
  fill_in "Password", :with => 'password'
  click_button "Sign in"
end

Given(/^there is an admin with "(.*?)" and "(.*?)"$/) do |email, password|
  User.create!(:email => email, :password => password, :password_confirmation => password)
end

Given(/^I am not logged in$/) do
  # nothing to do
end

Then(/^my settings should be as follows:$/) do |settings_table|
  settings_table.hashes.each do |settings_hash|
    Setting.send(settings_hash[:fieldname].to_sym).should == settings_hash[:value]
  end
end
