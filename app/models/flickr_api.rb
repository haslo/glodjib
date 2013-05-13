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

  def persisted?
    false
  end

  def get_images_with_tags(tags)
    assure_connection
    flickr.photos.search(:user_id => user_id, :tags => tags)
  end

  def fill_cache_for_tags(tags)
    images_for_tag = get_images_with_tags(tags)
    if images_for_tag.count > 0
      FlickrImage.delete_all
      images_for_tag.each do |portfolio_image|
        photo_info = flickr.photos.getInfo :photo_id => portfolio_image.id, :secret => portfolio_image.secret
        flickr_image = FlickrImage.new
        # @TODO fetch image data, cache, timeout, manage, etc.
      end
    end
  end

  def find_or_create_cache(user_id, tag)
    (flickr_user = FlickrUser.where("username = ?", user_id).first_or_create(:username => user_id)).save
    (flickr_tag = FlickrTag.where("tag_name = ?", tag).first_or_create(:tag_name => tag)).save
    FlickrCache.where("flickr_user_id = ? and flickr_tag_id = ?", flickr_user.id, flickr_tag.id).first_or_create(:flickr_user => flickr_user, :flickr_tag => flickr_tag)
  end

private

  def assure_connection
    FlickRaw.api_key = api_key
    FlickRaw.shared_secret = shared_secret
  end
end
