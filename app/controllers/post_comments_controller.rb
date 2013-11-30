class PostCommentsController < ApplicationController

  before_filter :configure_akismet, :only => [:create, :spam]

  expose(:post_comment, :attributes => :post_comment_params)
  expose(:post) { post_comment.post }

  def create
    if Setting.akismet_key.present?
      post_comment.is_spam = Akismet.spam?(akismet_attributes, request)
    end
    if post_comment.save
      redirect_to post_path(:id => post.shorthand)
    end
  end

  def spam
    if Setting.akismet_key.present?
      Akismet.submit_spam(akismet_attributes)
    end
    post_comment.spam!
    redirect_to post_path(:id => post.shorthand)
  end

  def destroy
    post_comment.deleted!
    redirect_to post_path(:id => post.shorthand)
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment, :name, :email, :url, :post_id)
  end
  private :post_comment_params

  def configure_akismet
    Akismet.key = Setting.akismet_key
    Akismet.blog = root_url
    Akismet.logger = Rails.logger
  end
  private :configure_akismet

  def akismet_attributes
    {
      :comment_author       => post_comment.name,
      :comment_author_url   => post_comment.url,
      :comment_author_email => post_comment.email,
      :comment_content      => post_comment.comment,
      :permalink            => post_url(:id => post.shorthand)
    }
  end
  private :akismet_attributes

end
