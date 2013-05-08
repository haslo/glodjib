source 'https://rubygems.org'

# core
gem 'rails', '~> 3.2.13'
gem 'mysql2', '= 0.3.11'

# libraries
gem 'bootstrap-sass', '~> 2.3.1.0'
gem 'simple_form', '~> 1.4.1'
gem 'country_select', '~> 1.1.3'
gem 'ruby-akismet', :require => 'akismet'
gem 'mini_magick'

# testing frameworks
group :test, :development do
  gem 'rspec-rails', '~> 2.0'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'webrat'
end

# server without content-length warning spam
group :test, :development do
  gem 'thin'
end

#defaults
gem 'jquery-rails'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
