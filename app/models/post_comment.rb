class PostComment < ActiveRecord::Base
  attr_accessible :comment, :name, :email, :url, :post_id

  validates_presence_of :name
  validates_presence_of :comment

  belongs_to :post
end
