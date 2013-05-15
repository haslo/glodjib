class PostTag < ActiveRecord::Base
  attr_accessible :tag_text

  validates_presence_of :tag_text
  validates_uniqueness_of :tag_text

  has_and_belongs_to_many :posts

  def tag_text=(value)
    write_attribute(:tag_text, value.blank? ? nil : value.strip.downcase.gsub(' ', '_').gsub(/[^0-9a-z_]/i, ''))
  end
end
