module Flickr::ImageService
  class << self

    def get_image_size_url(image, size)
      return nil unless image
      return nil unless image.size_for(size).present?
      image.size_for(size).source
    end

  end
end