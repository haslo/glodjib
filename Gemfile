source 'https://rubygems.org'

# core
gem 'rails', '~> 4.0.1'
gem 'pg', '~> 0.17.0'

# libraries
gem 'bootstrap-sass', '~> 3.0.2.0'
gem 'simple_form', '~> 3.0.0'
gem 'ruby-akismet', :require => 'akismet'
gem 'mini_magick'
gem 'flickraw'
gem 'tinymce-rails'
gem 'devise'
gem 'decent_exposure'

# delayed jobs
gem 'queue_classic'

# layout
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'haml-rails'
gem "font-awesome-rails"

# testing frameworks
group :test, :development do
  gem 'rspec-rails', '~> 2.0'
  gem 'shoulda-matchers', '~> 2.4.0'
  gem 'cucumber-rails', :require => false
  gem 'launchy'
  gem 'database_cleaner'
  gem 'webrat'
  gem 'simplecov'
  gem 'poltergeist'
end
gem 'nokogiri'

# server, deployment
group :test, :development do
  gem 'thin'
end
group :production do
  gem 'unicorn'
end
group :development do
  gem 'capistrano', "~> 2.15.0"
end
gem 'exception_notification'

# standards
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', :platforms => :ruby
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
