class FlickrCache < ActiveRecord::Base
  attr_accessible :flickr_user, :flickr_tag
  validates_presence_of :flickr_user, :flickr_tag

  belongs_to :flickr_user
  belongs_to :flickr_tag

  def timeout_over?
    timeout.nil? || timeout < Time.now
  end

  def refresh_timeout
    write_attribute(:timeout, Time.now + 24.hours)
  end
end
