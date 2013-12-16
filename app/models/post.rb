include ActionView::Helpers::SanitizeHelper

class Post < ActiveRecord::Base

  validates :title, :content, :shorthand, :presence => true
  validates :shorthand, :uniqueness =>  true
  validate :shorthand_starts_with_character

  has_and_belongs_to_many :post_tags
  has_many :post_comments

  scope :without_pages, lambda { where(:is_page => false) }
  scope :only_pages, lambda { where(:is_page => true) }

  scope :sorted, lambda { order(:created_at => :desc) }
  scope :with_id_or_shorthand, lambda { |id_or_shorthand|
    if id_or_shorthand.to_s.is_i?
      Post.where(:id => id_or_shorthand).first
    else
      Post.where(:shorthand => id_or_shorthand).first
    end
  }

  def title=(value)
    write_attribute(:title, value)
    if value
      unless read_attribute(:custom_shorthand)
        write_attribute(:shorthand, auto_shorthand(read_attribute(:title)))
      end
    end
  end

  def shorthand=(value)
    if value.blank?
      write_attribute(:custom_shorthand, false)
      write_attribute(:shorthand, auto_shorthand(read_attribute(:title)))
    else
      write_attribute(:custom_shorthand, true)
      write_attribute(:shorthand, auto_shorthand(value))
    end
  end

  def content=(value)
    write_attribute(:content, sanitize(value))
  end

  def content
    if read_attribute(:content).blank?
      return nil
    end
    read_attribute(:content).html_safe
  end

  def tags
    post_tags.collect{|post_tag| post_tag.tag_text}.join(', ')
  end

  def tags=(value)
    unless value.blank?
      post_tags.destroy_all
      value.split(',').each do |tag_text|
        post_tag = PostTag.where("tag_text = ?", PostTag.parse(tag_text)).first_or_create!(:tag_text => tag_text)
        post_tags << post_tag
      end
    end
  end

  def published_at
    created_at
  end

private

  def auto_shorthand(original_value)
    added_index = 0
    current_shorthand = generated_shorthand = original_value.blank? ? nil : original_value.strip.downcase.gsub(' ', '_').gsub(/[^0-9a-z_]/i, '')
    while Post.where(:shorthand => current_shorthand).count > 0
      current_shorthand = "#{generated_shorthand}_#{added_index}"
      added_index += 1
    end
    current_shorthand
  end

  def shorthand_starts_with_character
    if read_attribute(:shorthand).blank? || !(read_attribute(:shorthand)[0] =~ /[a-z]/i)
      errors.add(:shorthand, I18n.t('errors.custom_messages.shorthand_start_with_character'))
    end
  end

end
