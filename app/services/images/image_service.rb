module Images::ImageService
  class << self

    def get_url_from_id(image_id, size)
      image = Image.where(:id => image_id).first
      get_url_from_image(image, size)
    end

    def get_url_from_image(image, size)
      return nil unless image
      return nil unless image.size_for(size).present?
      image.size_for(size).source
    end

  end
end