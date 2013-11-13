class PostCommentsController < ApplicationController

  expose(:post_comment, :attributes => :post_comment_params)
  expose(:post) { post_comment.post }

  def create
    # TODO https://github.com/ysbaddaden/ruby-akismet#usage-1
    if post_comment.save
      redirect_to "/#{post.shorthand}"
    end
  end

  def spam
    post_comment.spam!
    redirect_to "/#{post.shorthand}"
  end

  def destroy
    post_comment.deleted!
    redirect_to "/#{post.shorthand}"
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment, :name, :email, :url, :post_id)
  end

end
