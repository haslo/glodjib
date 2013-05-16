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
    @api_key = Setting.flickr_api_key unless @api_key
    @shared_secret = Setting.flickr_shared_secret unless @shared_secret
    @flickr_user = FlickrUser.where("username = ?", Setting.flickr_user).first_or_create!(:username => Setting.flickr_user) unless @flickr_user
  end

  def persisted?
    false
  end
end
