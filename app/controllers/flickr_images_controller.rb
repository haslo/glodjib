class FlickrImagesController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  expose(:flickr_images) do
    flickr_api = FlickrAPI.new
    flickr_cache = flickr_api.find_or_create_cache(params[:portfolio])
    flickr_api.update_cache(flickr_cache)
    flickr_cache.flickr_tag.flickr_images.where("flickr_user_id = ?", flickr_cache.flickr_user.id).sorted
  end
  expose(:flickr_image) { FlickrImage.where(:flickr_id => params[:id]).first_or_initialize }
  expose(:previous_flickr_image) { flickr_images[flickr_images.find_index(flickr_image) - 1] }
  expose(:next_flickr_image) { flickr_images[flickr_images.find_index(flickr_image) + 1] || flickr_images[0] }
  expose(:portfolio) { params[:portfolio] }

  def index
    @title_parameter = [I18n.t('titles.flickr_images.portfolio'), portfolio.humanize].uniq.join(': ')
  end

  def show
    redirect_to(:action => 'index', :portfolio => portfolio) if flickr_image.new_record?
    @title_parameter = flickr_image.image_title
  end

  def reset_caches
    FlickrCache.destroy_all
    flash[:notice] = I18n.t('notices.flickr_images.cache_updated')
    redirect_to flickr_images_path
  end

end
