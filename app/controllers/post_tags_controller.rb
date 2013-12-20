class PostTagsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  expose(:post_tag) { PostTag.where((params[:id].is_i? ? :id : :tag_text) => params[:id]).first }
  expose(:posts) { post_tag.posts.sorted.paginate(:page => params[:page], :per_page => Setting.posts_per_page || DEFAULT_POSTS_PER_PAGE) }
  expose(:portfolios) { Hash[posts.map{|post| [post.id, Blog::PostService.portfolio(post.content)]}] }

  def show
    @title_parameter = post_tag.tag_text
    if posts.count <= 0
      flash[:error] = I18n.t('notices.tag.no_posts')
      redirect_to root_path
    end
  end

end
