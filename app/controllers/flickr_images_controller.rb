class FlickrImagesController < ApplicationController
  def portfolio
    flickr_api = FlickrAPI.new
    flickr_cache = flickr_api.find_or_create_cache('portfolio')
    flickr_api.update_cache(flickr_cache)
    @flickr_images = flickr_cache.flickr_tag.flickr_images.where("flickr_user_id = ?", flickr_cache.flickr_user.id)
  end

  def reset_caches
    FlickrCache.destroy_all
    FlickrTag.destroy_all
    redirect_to :portfolio
  end
end
