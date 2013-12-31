class FlickrImage < ActiveRecord::Base

  validates :flickr_id, :image_title, :presence => true

  scope :sorted, lambda { order(:position) }

  has_one :image
  has_many :image_sizes, :as => :linked_image

  def size_for(label)
    image_sizes.where(:label => label).first_or_initialize
  end

end
