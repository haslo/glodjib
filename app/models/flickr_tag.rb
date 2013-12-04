class FlickrTag < ActiveRecord::Base
  validates :tag_name, :presence => true

  has_and_belongs_to_many :flickr_images
  has_many :flickr_caches, :dependent => :destroy
end
