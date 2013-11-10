class FlickrImagesController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  expose(:flickr_images) do
    flickr_api = FlickrAPI.new
    flickr_cache = flickr_api.find_or_create_cache(params[:id])
    flickr_api.update_cache(flickr_cache)
    flickr_cache.flickr_tag.flickr_images.where("flickr_user_id = ?", flickr_cache.flickr_user.id)
  end

  def show
    @title_parameter = params[:id].humanize
  end

  def reset_caches
    FlickrCache.destroy_all
    flash[:notice] = I18n.t('notices.flickr_images.cache_updated')
    redirect_to portfolio_flickr_images_path
  end

end
