class FlickrCache < ActiveRecord::Base
  attr_accessible :flickr_user, :flickr_tag
  validates_presence_of :flickr_user, :flickr_tag

  belongs_to :flickr_user
  belongs_to :flickr_tag

  after_initialize do |flickr_cache|
    write_attribute(:timeout, Time.now + 24.hours)
  end

  def timeout_over?
    timeout < Time.now
  end
end
