class PostComment < ActiveRecord::Base
  attr_accessible :comment, :name, :email, :url, :post_id

  validates_presence_of :post_id, :name, :comment
  validates_uniqueness_of :comment, :message => I18n.t('notices.post_comment.duplicate')

  belongs_to :post

  scope :ham, where(:is_deleted => false).where(:is_spam => false)
  scope :spam, where(:is_spam => true)
  scope :deleted, where(:is_deleted => true)

  def name=(value)
    write_attribute(:name, strip_tags(value))
  end

  def email=(value)
    write_attribute(:email, strip_tags(value))
  end

  def url=(value)
    write_attribute(:url, strip_tags(value))
  end

  def comment=(value)
    write_attribute(:comment, sanitize(value))
  end

  def comment
    if read_attribute(:comment).blank?
      return nil
    end
    read_attribute(:comment).html_safe
  end
end
