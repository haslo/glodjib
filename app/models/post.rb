class Post < ActiveRecord::Base
  attr_accessible :title, :content, :shorthand
  validates_presence_of :title, :content, :shorthand
end
