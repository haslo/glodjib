class ImageSize < ActiveRecord::Base

  validates :linked_image_id, :presence => true

  belongs_to :linked_image, :polymorphic => true

end
