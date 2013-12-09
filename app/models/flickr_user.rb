class FlickrUser < ActiveRecord::Base

  validates :username, :presence => true

  has_many :flickr_caches
  has_many :flickr_tag_images
  has_many :flickr_images, :through => :flickr_tag_images

end
