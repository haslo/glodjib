class Gallery < ActiveRecord::Base
  include Concerns::ModelWithShorthand

  validates :special_usage, :inclusion => {:in => %w(frontpage)}, :allow_blank => true

  has_many :gallery_images
  has_many :images, :through => :gallery_images

  scope :sorted, lambda { order(:position => :asc).order(:created_at => :desc) }
  scope :only_portfolios, lambda { where(:is_portfolio =>  true) }
  scope :with_special_usage, lambda {|usage| where(:special_usage => usage)}

end
