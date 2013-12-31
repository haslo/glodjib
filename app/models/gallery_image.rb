class GalleryImage < ActiveRecord::Base

  self.table_name = 'galleries_images'

  belongs_to :image
  belongs_to :gallery

  scope :sorted, lambda { order(:position) }

end
