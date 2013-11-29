class FlickrImage < ActiveRecord::Base
  validates :flickr_id, :image_title, :presence => true

  scope :ordered, lambda { order(:flickr_id) }

  belongs_to :flickr_user
  has_and_belongs_to_many :flickr_tags
end
