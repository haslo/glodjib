require 'pp'

class PostsController < ApplicationController
  def frontpage
    @posts = Post.all
  end

  def index
    @posts = Post.all
  end

  def show
    redirect_to root_path and return
    posts = Post.where("id = ? or shorthand = ?", params[:id], params[:id])
    if posts.count > 0
      @post = posts.first
      @title_parameter = @post.title
    else
      flash[:error] = I18n.t('notices.post.not_found')
      redirect_to root_path
    end
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
