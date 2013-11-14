class PostComment < ActiveRecord::Base
  validates :post_id, :name, :comment, :presence => true
  validates :comment, :uniqueness => {:message => I18n.t('notices.post_comment.duplicate'), :scope => :is_deleted}, :unless => :is_deleted?

  belongs_to :post

  scope :ham, lambda { where(:is_deleted => false).where(:is_spam => false) }
  scope :spam, lambda { where(:is_spam => true) }
  scope :deleted, lambda { where(:is_deleted => true) }

  def name=(value)
    write_attribute(:name, ActionController::Base.helpers.strip_tags(value))
  end

  def email=(value)
    write_attribute(:email, ActionController::Base.helpers.strip_tags(value))
  end

  def url=(value)
    write_attribute(:url, ActionController::Base.helpers.strip_tags(value))
  end

  def comment=(value)
    write_attribute(:comment, ActionController::Base.helpers.sanitize(value))
  end

  def spam!
    self.is_spam = true
    save!
  end

  def deleted!
    self.is_deleted = true
    save!
  end

  def comment
    if read_attribute(:comment).blank?
      return nil
    end
    read_attribute(:comment).html_safe
  end
end
