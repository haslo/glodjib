class FlickrTag < ActiveRecord::Base
  attr_accessible :tag_name
  validates_presence_of :tag_name

  has_and_belongs_to_many :flickr_images
end
