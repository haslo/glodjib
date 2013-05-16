require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/.bundle/'
end

require 'cucumber/rails'
ActionController::Base.allow_rescue = false
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end
Cucumber::Rails::Database.javascript_strategy = :truncation

Setting.page_title = "the glodjib platform"
Setting.post_more_separator = "!!more!!"
