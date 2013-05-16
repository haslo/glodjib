require 'flickraw'

class FlickrAPI
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include Concerns::FlickrAPILib

  attr_accessor :api_key, :shared_secret, :flickr_user

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    # defaults
    # @TODO move to storage somewhere
    @api_key = '07c77887e7450e5d0d86781a7264c45c' unless @api_key
    @shared_secret = 'f6e1a90eb6ab7755' unless @shared_secret
    default_user_id = '80288388@N00'
    @flickr_user = FlickrUser.where("username = ?", default_user_id).first_or_create!(:username => default_user_id) unless @flickr_user
  end

  def persisted?
    false
  end
end
