class FlickrUser < ActiveRecord::Base
  validates :username, :presence => true

  has_many :flickr_images
  has_many :flickr_caches, :class_name => "FlickrCache"
end
