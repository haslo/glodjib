require 'flickraw'

class FlickrAPI
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

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

  def update_cache_for_tag(tag)
    update_cache(find_or_create_cache(tag))
  end

  def find_or_create_cache(tag, user_id = nil)
    user_id ||= @flickr_user.username
    flickr_user = FlickrUser.where("username = ?", user_id).first_or_create!(:username => user_id)
    flickr_tag = FlickrTag.where("tag_name = ?", tag).first_or_create!(:tag_name => tag)
    FlickrCache.where("flickr_user_id = ? and flickr_tag_id = ?", flickr_user.id, flickr_tag.id).first_or_create!(:flickr_user => flickr_user, :flickr_tag => flickr_tag)
  end

  def update_cache(flickr_cache)
    if flickr_cache.timeout_over?
      flickr_cache.flickr_tag.flickr_images.where("flickr_user_id = ?", flickr_cache.flickr_user.id).each do |flickr_image|
        flickr_image.flickr_tags.delete(flickr_cache.flickr_tag)
      end
      images_from_remote = get_images_from_remote(flickr_cache)
      if images_from_remote.count > 0
        images_from_remote.each do |portfolio_image|
          photo_info = flickr.photos.getInfo :photo_id => portfolio_image.id, :secret => portfolio_image.secret
          flickr_image = FlickrImage.where("flickr_id = ?", portfolio_image.id).first_or_create!(:flickr_id => portfolio_image.id, :image_title => photo_info.title, :flickr_user => flickr_cache.flickr_user)
          photo_info.tags.each do |tag_name|
            flickr_tag = FlickrTag.where("tag_name = ?", tag_name.to_s).first_or_create!(:tag_name => tag_name.to_s)
            flickr_tag.flickr_images << flickr_image
            flickr_tag.save
          end
          flickr_image.image_description = photo_info.description
          flickr_image.full_flickr_url = photo_info.urls.url[0]
          flickr_image.flickr_thumbnail_url = FlickRaw.url_q(photo_info) # square 150
          photo_exif = flickr.photos.getExif :photo_id => portfolio_image.id, :secret => portfolio_image.secret
          flickr_image.camera = photo_exif["camera"]
          photo_exif["exif"].each do |exif_line|
            flickr_image.aperture = exif_line["clean"] if exif_line["tag"] == "FNumber"
            flickr_image.shutter = exif_line["clean"] if exif_line["tag"] == "ExposureTime"
            flickr_image.iso = exif_line["raw"] if exif_line["tag"] == "ISO"
            flickr_image.focal_length = exif_line["clean"] if exif_line["tag"] == "FocalLength"
          end
          flickr_image.save
        end
      end
      flickr_cache.refresh_timeout
      return true
    end
    false
  end

  def get_images_from_remote(flickr_cache)
    FlickRaw.api_key = api_key
    FlickRaw.shared_secret = shared_secret
    flickr.photos.search(:user_id => flickr_cache.flickr_user.username, :tags => flickr_cache.flickr_tag.tag_name)
  end
end
