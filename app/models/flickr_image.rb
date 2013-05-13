class FlickrImage < ActiveRecord::Base
  attr_accessible :flickr_username, :flickr_id, :image_title, :image_description, :aperture, :shutter, :iso, :focal_length
  validates_presence_of :flickr_username, :flickr_id, :image_title
end
