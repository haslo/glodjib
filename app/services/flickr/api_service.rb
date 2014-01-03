module Flickr::APIService
  class << self

    def fetch_image_by_id(target_gallery_id, remote_image_id)
      target_gallery = Gallery.find(target_gallery_id)
      fetch_images_with_block(target_gallery) do
        images_from_remote = flickr.photos.search(:user_id => Flickr::ParameterService.flickr_user, :tags => tag_name)
        if images_from_remote.count > 0
          images_from_remote.each do |image_from_api|
            add_gallery_image(target_gallery, image_from_api.id, image_from_api.secret)
          end
        end
      end
    end

    def fetch_images_by_tag(target_gallery_id, tag_name)
      target_gallery = Gallery.find(target_gallery_id)
      fetch_images_with_block(target_gallery) do
        add_gallery_image(target_gallery, remote_image_id)
      end
    end

    def fetch_images_with_block(target_gallery, &block)
      begin
        ActiveRecord::Base.transaction do
          assure_connection
          yield
          target_gallery.updated_at = Time.now
          target_gallery.pending_updates = [target_gallery.pending_updates - 1, 0].max
          target_gallery.save
        end
      rescue
        ActiveRecord::Base.transaction do
          target_gallery.pending_updates = [target_gallery.pending_updates - 1, 0].max
          target_gallery.save
        end
      end
    end

    def add_gallery_image(target_gallery, remote_image_id, secret = nil)
      photo_info = flickr.photos.getInfo(:photo_id => remote_image_id, :secret => secret)
      flickr_image = FlickrImage.where("flickr_id = ?", remote_image_id).first_or_initialize(:flickr_id => remote_image_id)
      extract_basic_image_info(Flickr::ParameterService.flickr_user, flickr_image, photo_info)
      extract_exif_info(flickr_image, remote_image_id, secret)
      flickr_image.save
      extract_size_info(flickr_image, flickr.photos.getSizes(:photo_id => remote_image_id, :secret => secret))
      image = flickr_image.image
      if image.nil?
        image = Image.new
        image.flickr_image = flickr_image
        image.image_title = flickr_image.image_title
        image.save
      end
      target_gallery.images << image unless target_gallery.images.include?(image)
    end
    private :add_gallery_image

    def extract_basic_image_info(flickr_user, flickr_image, photo_info)
      flickr_image.image_title = photo_info.title
      flickr_image.flickr_user = flickr_user
      flickr_image.image_description = photo_info.description
      flickr_image.date_taken = photo_info.dates.taken
      flickr_image.date_posted = Time.at(photo_info.dates.posted.to_i).to_datetime
      flickr_image.full_flickr_url = FlickRaw.url_photopage(photo_info)
    end
    private :extract_basic_image_info

    def extract_exif_info(flickr_image, remote_image_id, secret = nil)
      photo_exif = flickr.photos.getExif :photo_id => remote_image_id, :secret => secret
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
      flickr_image.image_sizes.destroy_all
      api_sizes.each do |api_size|
        image_size = ImageSize.new(:linked_image => flickr_image)
        fields_from_api.each do |field_from_api|
          image_size.send("#{field_from_api}=", api_size[field_from_api])
        end
        image_size.save!
      end
    end
    private :extract_size_info

    def assure_connection
      FlickRaw.api_key = Flickr::ParameterService.api_key
      FlickRaw.shared_secret = Flickr::ParameterService.shared_secret
    end
    private :assure_connection

  end
end