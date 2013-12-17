class FlickrImagesController < ApplicationController

  layout 'minimal'

  before_filter :authenticate_user!, :except => [:show]

  expose(:flickr_images) do
    flickr_cache = Flickr::CacheService.find_or_create_cache(portfolio)
    flickr_cache.flickr_tag.flickr_tag_images.where(:flickr_user_id => flickr_cache.flickr_user.id).sorted.map(&:flickr_image)
  end
  expose(:flickr_image) { FlickrImage.where(:id => params[:id]).first }
  expose(:previous_flickr_image) { portfolio.present? ? flickr_images[flickr_images.find_index(flickr_image) - 1] : nil }
  expose(:next_flickr_image) { portfolio.present? ? (flickr_images[flickr_images.find_index(flickr_image) + 1] || flickr_images[0]) : nil }
  expose(:portfolio) { params[:portfolio] }

  def show
    redirect_to(root_path) unless flickr_image.present?
    @title_parameter = flickr_image.image_title
  end

end
