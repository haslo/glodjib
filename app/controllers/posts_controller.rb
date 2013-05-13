class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by_shorthand(params[:id])
    @post = Post.find(params[:id]) unless @post
    unless @post
      flash[:error] = I18n.t('notices.post.not_found')
      redirect_to root_path and return
    end
    @title_parameter = @post.title
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
