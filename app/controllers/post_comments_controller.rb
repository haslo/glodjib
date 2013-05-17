class PostCommentsController < ApplicationController
  def create
    posts = Post.where("id = ? or shorthand = ?", params[:post_id], params[:post_id])
    if posts.count > 0
      post = posts.first
      @post_comment = PostComment.new(params[:post_comment])
      if @post_comment.save
        redirect_to post_path(:id => post.shorthand)
      else
        @title_parameter = @post_comment.post.title
      end
    else
      redirect_to root_path
    end
  end
end
