class FlickrImage < ActiveRecord::Base

  validates :flickr_id, :image_title, :presence => true

  scope :sorted, lambda { order(:position) }

  belongs_to :flickr_user
  has_many :flickr_tag_images
  has_many :flickr_tags, :through => :flickr_tag_images
  has_many :flickr_image_sizes

  def size_for(label)
    flickr_image_sizes.where(:label => label).first
  end

end
