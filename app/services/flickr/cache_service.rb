module Flickr::CacheService
  class << self

    def find_or_create_cache(tag)
      flickr_user = Flickr::ParameterService.flickr_user
      flickr_tag = FlickrTag.where("tag_name = ?", tag).first_or_create!(:tag_name => tag)
      flickr_cache = FlickrCache.where("flickr_caches.flickr_user_id = ? and flickr_caches.flickr_tag_id = ?", flickr_user.id, flickr_tag.id).first_or_initialize(:flickr_user => flickr_user, :flickr_tag => flickr_tag)
      if flickr_cache.new_record?
        flickr_cache.save
        reset_cache(flickr_cache.id)
      end
      flickr_cache
    end

    def cleanup_caches
      FlickrCache.all.each do |flickr_cache|
        if flickr_cache.flickr_user != Flickr::ParameterService.flickr_user
          destroy_cache(flickr_cache.id)
        end
      end
    end

    def reset_caches_by_tag(tag_name)
      updated_caches = []
      FlickrCache.all.each do |flickr_cache|
        if flickr_cache.flickr_tag.tag_name == tag_name
          flickr_cache.reset_pending = true
          flickr_cache.save!
          QC.enqueue('Flickr::CacheService.reset_cache', flickr_cache.id)
          updated_caches << flickr_cache.id
        end
      end
      updated_caches
    end

    def destroy_caches_by_tag(tag_name)
      FlickrCache.all.each do |flickr_cache|
        if flickr_cache.flickr_tag.tag_name == tag_name
          destroy_cache(flickr_cache.id)
        end
      end
    end

    def reset_all_caches
      updated_caches = []
      FlickrCache.all.each do |flickr_cache|
        flickr_cache.reset_pending = true
        flickr_cache.save!
        QC.enqueue('Flickr::CacheService.reset_cache', flickr_cache.id)
        updated_caches << flickr_cache.id
      end
      updated_caches
    end

    def destroy_all_caches
      FlickrCache.all.each do |flickr_cache|
        destroy_cache(flickr_cache.id)
      end
    end

    def reset_cache(flickr_cache_id)
      puts "starting reset for #{flickr_cache_id}"
      ActiveRecord::Base.transaction do
        flickr_cache = FlickrCache.find(flickr_cache_id)
        assure_connection
        flickr_cache.save if flickr_cache.new_record?
        FlickrTagImage.where("flickr_tag_id = ? and flickr_user_id = ?", flickr_cache.flickr_tag.id, flickr_cache.flickr_user.id).destroy_all
        images_from_remote = get_images_from_remote(flickr_cache)
        if images_from_remote.count > 0
          images_from_remote.each do |image_from_api|
            photo_info = flickr.photos.getInfo(:photo_id => image_from_api.id, :secret => image_from_api.secret)
            flickr_image = FlickrImage.where("flickr_id = ?", image_from_api.id).first_or_initialize(:flickr_id => image_from_api.id)
            extract_basic_image_info(flickr_cache, flickr_image, photo_info)
            extract_exif_info(flickr_image, image_from_api)
            flickr_image.save
            extract_tags(flickr_image, photo_info)
            extract_size_info(flickr_image, flickr.photos.getSizes(:photo_id => image_from_api.id))
          end
        end
        flickr_cache.updated_at = Time.now
        flickr_cache.reset_pending = false
        flickr_cache.save
      end
      puts "reset complete for #{flickr_cache_id}"
    end

    def destroy_cache(flickr_cache_id)
      ActiveRecord::Base.transaction do
        assure_connection
        flickr_cache = FlickrCache.find(flickr_cache_id)
        flickr_cache.flickr_tag.flickr_images.where(:flickr_user_id => flickr_cache.flickr_user.id).each do |flickr_image|
          flickr_image.flickr_tags.delete(flickr_cache.flickr_tag)
          flickr_image.save
        end
        flickr_cache.destroy
      end
    end

    def extract_tags(flickr_image, photo_info)
      photo_info.tags.each do |tag_name|
        flickr_tag = FlickrTag.where("tag_name = ?", tag_name.to_s).first_or_create!(:tag_name => tag_name.to_s)
        FlickrTagImage.create! do |new_tag_link|
          new_tag_link.flickr_image = flickr_image
          new_tag_link.flickr_tag = flickr_tag
          new_tag_link.flickr_user = flickr_image.flickr_user
        end
      end
    end
    private :extract_tags

    def extract_basic_image_info(flickr_cache, flickr_image, photo_info)
      flickr_image.image_title = photo_info.title
      flickr_image.flickr_user = flickr_cache.flickr_user
      flickr_image.image_description = photo_info.description
      flickr_image.date_taken = photo_info.dates.taken
      flickr_image.date_posted = Time.at(photo_info.dates.posted.to_i).to_datetime
      flickr_image.full_flickr_url = FlickRaw.url_photopage(photo_info)
    end
    private :extract_basic_image_info

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
    private :extract_exif_info

    def extract_individual_exif(flickr_image, property, exif_line, key)
      if exif_line["tag"] == key
        flickr_image.send("#{property}=", (exif_line["clean"] || exif_line["raw"]))
      end
    end
    private :extract_individual_exif

    def extract_size_info(flickr_image, api_sizes)
      fields_from_api = %w(label width height source url media)
      flickr_image.flickr_image_sizes.destroy_all
      api_sizes.each do |api_size|
        flickr_image_size = FlickrImageSize.new(:flickr_image => flickr_image)
        fields_from_api.each do |field_from_api|
          flickr_image_size.send("#{field_from_api}=", api_size[field_from_api])
        end
        flickr_image_size.save!
      end
    end
    private :extract_size_info

    def get_images_from_remote(flickr_cache)
      flickr.photos.search(:user_id => flickr_cache.flickr_user.username, :tags => flickr_cache.flickr_tag.tag_name)
    end
    private :get_images_from_remote

    def assure_connection
      FlickRaw.api_key = Flickr::ParameterService.api_key
      FlickRaw.shared_secret = Flickr::ParameterService.shared_secret
    end
    private :assure_connection

  end
end