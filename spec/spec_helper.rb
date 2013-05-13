# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end

shared_examples_for "a model that accepts text" do |property|
  let(:text_input) { "some text" }

  it "accepts text input for #{property}" do
    record = new_valid_record
    record.send(:"#{property}=", text_input)
    record.errors[property.to_sym].should have(0).errors
  end

  it "returns the value that was set for #{property}" do
    record = new_valid_record
    record.send(:"#{property}=", text_input)
    record.send(:"#{property}").should == text_input
  end
end

shared_examples_for "a model that accepts a boolean" do |property|
  let(:boolean_input) { true }

  it "accepts text input for #{property}" do
    record = new_valid_record
    record.send(:"#{property}=", boolean_input)
    record.errors[property.to_sym].should have(0).errors
  end

  it "returns the value that was set for #{property}" do
    record = new_valid_record
    record.send(:"#{property}=", boolean_input)
    record.send(:"#{property}").should == boolean_input
  end
end

shared_examples_for "a model that accepts html with links and formatting" do |property|
  let(:text_input) { "some <strong>bold</strong> text <a href=\"\">with link</a>" }

  it "accepts html input for #{property}" do
    record = new_valid_record
    record.send(:"#{property}=", text_input)
    record.errors[property.to_sym].should have(0).errors
  end

  it "returns the value that was set for #{property}" do
    record = new_valid_record
    record.send(:"#{property}=", text_input)
    record.send(:"#{property}").should == text_input
  end
end
