class Post < ActiveRecord::Base
  attr_accessible :title, :content, :shorthand
  validates_presence_of :title, :content, :shorthand

  def title=(value)
    unless read_attribute(:shorthand)
      write_attribute(:shorthand, value)
    end
    write_attribute(:title, value)
  end
end
