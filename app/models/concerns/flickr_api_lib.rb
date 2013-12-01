module Concerns::FlickrAPILib

  extend ActiveSupport::Concern

  def find_or_create_cache(tag, user_id = nil)
    user_id ||= @flickr_user.username
    flickr_user = FlickrUser.where("username = ?", user_id).first_or_create!(:username => user_id)
    flickr_tag = FlickrTag.where("tag_name = ?", tag).first_or_create!(:tag_name => tag)
    FlickrCache.where("flickr_user_id = ? and flickr_tag_id = ?", flickr_user.id, flickr_tag.id).first_or_create!(:flickr_user => flickr_user, :flickr_tag => flickr_tag)
  end

  def reset_caches
    FlickrCache.all.each do |flickr_cache|
      if flickr_cache.flickr_user_id == Setting.flickr_user_id
        reset_cache(flickr_cache)
      else
        flickr_cache.destroy
      end
    end
  end

  def reset_cache(flickr_cache)
    assure_connection
    flickr_cache.flickr_tag.flickr_images.where("flickr_user_id = ?", flickr_cache.flickr_user.id).each do |flickr_image|
      flickr_image.flickr_tags.delete(flickr_cache.flickr_tag)
      flickr_image.save
    end
    images_from_remote = get_images_from_remote(flickr_cache)
    if images_from_remote.count > 0
      images_from_remote.each do |portfolio_image|
        photo_info = flickr.photos.getInfo(:photo_id => portfolio_image.id, :secret => portfolio_image.secret)
        flickr_image = FlickrImage.where("flickr_id = ?", portfolio_image.id).first_or_initialize(:flickr_id => portfolio_image.id)
        extract_basic_image_info(flickr_cache, flickr_image, photo_info)
        extract_exif_info(flickr_image, portfolio_image)
        extract_size_info(flickr_image, flickr.photos.getSizes(:photo_id => image_from_api.id))
        extract_tags(flickr_image, photo_info)
        flickr_image.position = FlickrImage.maximum('position') + 1
        flickr_image.save
      end
    end
    flickr_cache.save
  end

  def extract_tags(flickr_image, photo_info)
    photo_info.tags.each do |tag_name|
      flickr_tag = FlickrTag.where("tag_name = ?", tag_name.to_s).first_or_create!(:tag_name => tag_name.to_s)
      flickr_tag.flickr_images << flickr_image unless flickr_tag.flickr_images.include?(flickr_image)
      flickr_tag.save
    end
  end

  def extract_basic_image_info(flickr_cache, flickr_image, photo_info)
    flickr_image.image_title = photo_info.title
    flickr_image.flickr_user = flickr_cache.flickr_user
    flickr_image.image_description = photo_info.description
    flickr_image.full_flickr_url = FlickRaw.url_photopage(photo_info)
  end

  def extract_exif_info(flickr_image, portfolio_image)
    photo_exif = flickr.photos.getExif :photo_id => portfolio_image.id, :secret => portfolio_image.secret
    flickr_image.camera = photo_exif["camera"]
    photo_exif["exif"].each do |exif_line|
      extract_individual_exif(flickr_image, :aperture, exif_line, "FNumber")
      extract_individual_exif(flickr_image, :shutter, exif_line, "ExposureTime")
      extract_individual_exif(flickr_image, :iso, exif_line, "ISO")
      extract_individual_exif(flickr_image, :focal_length, exif_line, "FocalLength")
    end
  end

  def extract_individual_exif(flickr_image, property, exif_line, key)
    if exif_line["tag"] == key
      flickr_image.send("#{property}=", (exif_line["clean"] || exif_line["raw"]))
    end
  end

  def extract_size_info(flickr_image, api_sizes)
    fields_from_api = %w(label width height source url media)
    flickr_image.flickr_image_sizes.destroy_all
    api_sizes.each do |api_size|
      flickr_image_size = FlickrImageSize.new(:flickr_image => flickr_image)
      fields_from_api.each do |field_from_api|
        flickr_image_size.send("#{field_from_api}=", api_size[field_from_api])
      end
      flickr_image_size.save
    end
  end

  def get_images_from_remote(flickr_cache)
    assure_connection
    flickr.photos.search(:user_id => flickr_cache.flickr_user.username, :tags => flickr_cache.flickr_tag.tag_name)
  end

private

  def assure_connection
    FlickRaw.api_key = api_key
    FlickRaw.shared_secret = shared_secret
  end

end
