class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:frontpage, :show]

  def frontpage
    @posts = Post.all
  end

  def index
    @posts = Post.all
    render 'frontpage'
  end

  def show
    posts = Post.where((params[:id].is_i? ? :id : :shorthand) => params[:id])
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

  def edit
    posts = Post.where("id = ?", params[:id])
    if posts.count > 0
      if request.get?
        @post = posts.first
        @title_parameter = @post.title
      elsif request.patch?
        @post = Post.find(params[:id])
        if @post.update_attributes(params[:post])
          flash[:notice] = I18n.t('notices.post.updated')
          redirect_to posts_path
        end
      end
    else
      flash[:error] = I18n.t('notices.post.not_found')
      redirect_to posts_path
    end
  end

  def destroy
    posts = Post.where("id = ?", params[:id])
    if posts.count > 0
      post = posts.first
      post.destroy
      flash[:notice] = I18n.t('notices.post.destroyed')
      redirect_to posts_path
    else
      flash[:error] = I18n.t('notices.post.not_found')
      redirect_to posts_path
    end
  end
end
