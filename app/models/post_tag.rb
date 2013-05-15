class PostTag < ActiveRecord::Base
  attr_accessible :tag_text

  validates_presence_of :tag_text
  validates_uniqueness_of :tag_text

  has_and_belongs_to_many :posts
end
