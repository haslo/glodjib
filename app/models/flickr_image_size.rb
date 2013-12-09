class FlickrImageSize < ActiveRecord::Base

  validates :flickr_image_id, :presence => true

  belongs_to :flickr_image

end
