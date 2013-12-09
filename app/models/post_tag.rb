class PostTag < ActiveRecord::Base

  validates :tag_text, :presence => true, :uniqueness => true

  has_and_belongs_to_many :posts

  def tag_text=(value)
    write_attribute(:tag_text, PostTag.parse(value))
  end

  def self.parse(value)
    value.blank? ? nil : value.strip.downcase.gsub(' ', '_').gsub(/[^0-9a-z_]/i, '')
  end

end
