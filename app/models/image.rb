class Image < ActiveRecord::Base

  validates :image_title, :presence => true

  has_many :gallery_images
  has_many :galleries, :through => :gallery_images
  belongs_to :flickr_image
  has_many :image_sizes, :as => :linked_image

  def size_for(label)
    if flickr_image.present? && flickr_image.size_for(label).present?
      flickr_image.size_for(label)
    else
      image_sizes.where(:label => label).first
    end
  end

  def method_missing(message, *args, &block)
    if flickr_image.present? && [:image_description, :aperture, :shutter, :iso, :focal_length, :camera, :date_taken, :full_flickr_url, :date_posted].include?(message)
      read_attribute(message) || flickr_image.send(message)
    else
      super
    end
  end

end
