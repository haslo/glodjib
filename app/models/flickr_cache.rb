class FlickrCache < ActiveRecord::Base
  validates :flickr_user, :flickr_tag, :presence => true

  belongs_to :flickr_user
  belongs_to :flickr_tag

  def timeout_over?
    timeout.nil? || timeout < Time.now
  end

  def refresh_timeout
    write_attribute(:timeout, Time.now + 24.hours)
  end
end
