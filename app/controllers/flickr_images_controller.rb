class FlickrImagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:portfolio]

  def portfolio
    flickr_api = FlickrAPI.new
    flickr_cache = flickr_api.find_or_create_cache('portfolio')
    flickr_api.update_cache(flickr_cache)
    @flickr_images = flickr_cache.flickr_tag.flickr_images.where("flickr_user_id = ?", flickr_cache.flickr_user.id)
  end

  def reset_caches
    FlickrCache.destroy_all
    flash[:notice] = I18n.t('notices.flickr_images.cache_updated')
    redirect_to portfolio_path
  end
end
