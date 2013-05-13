require 'flickraw'

class FlickrAPI
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :api_key, :shared_secret, :user_id

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    # defaults
    # @TODO move to storage somewhere
    @api_key = '07c77887e7450e5d0d86781a7264c45c' unless @api_key
    @shared_secret = 'f6e1a90eb6ab7755' unless @shared_secret
    @user_id = '80288388@N00' unless @user_id
  end

  def get_images_with_tag(tags)
    assure_connection
    flickr.photos.search(:user_id => user_id, :tags => tags)
  end

  def persisted?
    false
  end

private

  def assure_connection
    FlickRaw.api_key = api_key
    FlickRaw.shared_secret = shared_secret
  end
end
