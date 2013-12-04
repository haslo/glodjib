module Flickr::ImageService
  class << self

    def get_blog_post_image_url(image_id)
      image = FlickrImage.where(:id => image_id).first
      get_image_size_url(image, 'Small 320')
    end

    def get_image_size_url(image, size)
      return nil unless image
      return nil unless image.size_for(size).present?
      image.size_for(size).source
    end

  end
end