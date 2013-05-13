include ActionView::Helpers::SanitizeHelper

class Post < ActiveRecord::Base
  attr_accessible :title, :content, :shorthand
  validates_presence_of :title, :content, :shorthand
  validates_uniqueness_of :shorthand

  def title=(value)
    write_attribute(:title, value)
    if value
      unless read_attribute(:custom_shorthand)
        write_attribute(:shorthand, auto_shorthand)
      end
    end
  end

  def shorthand=(value)
    if value.blank?
      write_attribute(:custom_shorthand, false)
      write_attribute(:shorthand, auto_shorthand)
    else
      write_attribute(:custom_shorthand, true)
      write_attribute(:shorthand, value)
    end
  end

  def content
    if read_attribute(:content).blank?
      return read_attribute(:content)
    end
    sanitize(read_attribute(:content)).html_safe
  end

private

  def auto_shorthand
    read_attribute(:title).blank? ? nil : read_attribute(:title).downcase.gsub(' ', '_').gsub(/[^0-9a-z_]/i, '')
  end
end
