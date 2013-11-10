class PostTagsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  expose(:post_tag) { PostTag.where((params[:id].is_i? ? :id : :tag_text) => params[:id]).first }
  expose(:posts) { post_tag.posts }

  def show
    @title_parameter = post_tag.tag_text
    if posts.count <= 0
      flash[:error] = I18n.t('notices.tag.no_posts')
      redirect_to root_path
    end
  end

end
