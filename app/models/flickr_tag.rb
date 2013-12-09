class FlickrTag < ActiveRecord::Base

  validates :tag_name, :presence => true

  has_many :flickr_tag_images
  has_many :flickr_images, :through => :flickr_tag_images
  has_many :flickr_caches, :dependent => :destroy

end
