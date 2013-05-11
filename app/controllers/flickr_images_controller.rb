class FlickrImagesController < ApplicationController
  def index
  end

  def portfolio
    portfolio_images = FlickrAPI.new.get_images_with_tag('portfolio')
    if portfolio_images.count > 0
      FlickrImage.delete_all
      portfolio_images.each do |portfolio_image|
        photo_info = flickr.photos.getInfo :photo_id => portfolio_image.id, :secret => portfolio_image.secret
        flickr_image = FlickrImage.new
        # @TODO fetch image data, cache, timeout, manage, etc.
      end
    end
    flash[:notice] = I18n.t('notices.flickr_images.cache_updated', :count => portfolio_images.count)
  end
end
