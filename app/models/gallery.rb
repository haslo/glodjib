class Gallery < ActiveRecord::Base
  include Concerns::ModelWithShorthand

  has_many :gallery_images
  has_many :images, :through => :gallery_images

  scope :sorted, lambda { order(:position => :asc).order(:created_at => :desc) }
  scope :only_portfolios, lambda { where(:is_portfolio =>  true) }

end
