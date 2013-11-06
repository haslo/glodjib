# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Glodjib::Application.initialize!

class String
  def is_i?
    !!(self =~ /^[-+]?[0-9]+$/)
  end
end
