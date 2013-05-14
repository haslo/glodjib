class FlickrTag < ActiveRecord::Base
  attr_accessible :tag_name
  validates_presence_of :tag_name
  validate :tag_name_alphanumeric

  has_and_belongs_to_many :flickr_images
  has_many :flickr_caches, :class_name => "FlickrCache"

private

  def tag_name_alphanumeric
    if read_attribute(:tag_name).blank? || !(read_attribute(:tag_name) =~ /^[a-z0-9]+[-a-z0-9]*[a-z0-9]+$/i)
      errors.add(:tag_name, I18n.t('errors.custom_messages.tag_name_alphanumeric'))
    end
  end
end
