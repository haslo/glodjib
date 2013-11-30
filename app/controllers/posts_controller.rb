class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show, :feed]

  expose(:posts) { Post.without_pages.sorted }
  expose(:post, :attributes => :post_params) { get_or_build_post }

  before_filter :mandatory_post, :only => [:show, :edit, :update, :destroy]

  def show
    @title_parameter = post.title
  end

  def create
    if post.save
      flash[:notice] = I18n.t('notices.post.created')
      redirect_to posts_path
    else
      flash[:error] = I18n.t('notices.post.invalid')
      render 'new'
    end
  end

  def update
    if post.update_attributes(post_params)
      flash[:notice] = I18n.t('notices.post.updated')
      redirect_to post_path(:id => post.shorthand)
    end
  end

  def destroy
    if post.present? && post.destroy
      flash[:notice] = I18n.t('notices.post.destroyed')
    else
      flash[:error] = I18n.t('notices.post.not_found')
    end
    redirect_to posts_path
  end

  def get_or_build_post
    if params[:id].present?
      post = Post.with_id_or_shorthand(params[:id])
      post || build_post
    else
      build_post
    end
  end
  private :get_or_build_post

  def build_post
    if params[:post].present?
      Post.new(post_params)
    else
      Post.new
    end
  end
  private :build_post

  def post_params
    params.require(:post).permit(:title, :content, :shorthand, :tags)
  end
  private :post_params

  def mandatory_post
    if post.class.name != 'Post' || post.new_record?
      flash[:error] = I18n.t('notices.post.not_found')
      redirect_to root_path
    end
  end
  private :mandatory_post

end
