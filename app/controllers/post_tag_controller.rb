class PostTagController < ApplicationController
  def show
    post_tags = PostTag.where("id = ? or tag_text = ?", params[:id], params[:id])
    if post_tags.count > 0
      @post_tag = post_tags.first
      @title_parameter = @post_tag.tag_text
      @posts = @post_tag.posts
      if @post_tag.posts.count <= 0
        flash[:error] = I18n.t('notices.tag.no_posts')
        redirect_to root_path
      end
    else
      flash[:error] = I18n.t('notices.tag.not_found')
      redirect_to root_path
    end
  end
end
