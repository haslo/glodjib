class FlickrImage < ActiveRecord::Base
  attr_accessible :flickr_id, :image_title, :image_description, :aperture, :shutter, :iso, :focal_length, :flickr_user, :flickr_tags, :full_flickr_url, :flickr_thumbnail_url
  validates_presence_of :flickr_id, :image_title

  belongs_to :flickr_user
  has_and_belongs_to_many :flickr_tags
end
