class FlickrCache < ActiveRecord::Base

  validates :flickr_user, :flickr_tag, :presence => true

  belongs_to :flickr_user
  belongs_to :flickr_tag

end
