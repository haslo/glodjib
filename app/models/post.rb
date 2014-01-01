include ActionView::Helpers::SanitizeHelper

class Post < ActiveRecord::Base
  include Concerns::ModelWithShorthand

  validates :title, :content, :presence => true

  has_and_belongs_to_many :post_tags
  has_many :post_comments

  scope :without_pages, lambda { where(:is_page => false) }
  scope :only_pages, lambda { where(:is_page => true) }
  scope :sorted, lambda { order(:created_at => :desc) }

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

end
