class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(params[:post])
    if @post.valid? && @post.save
      flash[:notice] = I18n.t('notices.post.created')
      redirect_to posts_path
    else
      flash[:error] = I18n.t('notices.post.invalid')
      render 'new'
    end
  end
end
