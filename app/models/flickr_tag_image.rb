class FlickrTagImage < ActiveRecord::Base

  belongs_to :flickr_user
  belongs_to :flickr_tag
  belongs_to :flickr_image

  scope :sorted, lambda { order(:position) }

end
