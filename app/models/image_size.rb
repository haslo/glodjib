class ImageSize < ActiveRecord::Base

  validates :linked_image_id, :presence => true

  belongs_to :linked_image, :polymorphic => true

  FLICKR_SIZES = [
    { :name => :thumbnail, :max_size => 100, :flickr_suffix => '_t' },
    { :name => :small240, :max_size => 240, :flickr_suffix => '_m' },
    { :name => :small320, :max_size => 320, :flickr_suffix => '_n' },
    { :name => :medium, :max_size => 500, :flickr_suffix => '' },
    { :name => :medium640, :max_size => 640, :flickr_suffix => '_z' },
    { :name => :medium800, :max_size => 800, :flickr_suffix => '_c' },
    { :name => :large, :max_size => 1024, :flickr_suffix => '_b' }
  ].freeze

end
