class ApplicationController < ActionController::Base

  protect_from_forgery(:with => :exception)
  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  expose(:background_images) do
    flickr_api = FlickrAPI.new
    flickr_cache = flickr_api.find_or_create_cache(flickr_tag_for_background)
    flickr_api.update_cache(flickr_cache)
    flickr_cache.flickr_tag.flickr_images.where("flickr_user_id = ?", flickr_cache.flickr_user.id)
  end
  expose(:background_image) { background_images.sample }

  def flickr_tag_for_background
    Setting.flickr_background_tag
  end

end
