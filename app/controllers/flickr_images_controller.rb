class FlickrImagesController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  expose(:flickr_images) do
    flickr_api = FlickrAPI.new
    flickr_cache = flickr_api.find_or_create_cache(params[:portfolio])
    flickr_api.update_cache(flickr_cache)
    flickr_cache.flickr_tag.flickr_images.where("flickr_user_id = ?", flickr_cache.flickr_user.id)
  end

  def index
    @title_parameter = [I18n.t('titles.flickr_images.portfolio'), params[:portfolio].humanize].uniq.join(': ')
  end

  def reset_caches
    FlickrCache.destroy_all
    flash[:notice] = I18n.t('notices.flickr_images.cache_updated')
    redirect_to portfolio_flickr_images_path
  end

end
