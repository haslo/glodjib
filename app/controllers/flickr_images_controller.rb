class FlickrImagesController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  expose(:flickr_images) do
    flickr_api = FlickrAPI.new
    flickr_cache = flickr_api.find_or_create_cache(params[:id])
    flickr_api.update_cache(flickr_cache)
    flickr_cache.flickr_tag.flickr_images.where("flickr_user_id = ?", flickr_cache.flickr_user.id)
  end

  def index
    redirect_to :action => :show, :id => 'portfolio'
  end

  def reset_caches
    FlickrCache.destroy_all
    flash[:notice] = I18n.t('notices.flickr_images.cache_updated')
    redirect_to portfolio_path
  end

end
