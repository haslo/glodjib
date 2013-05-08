require 'flickraw'

class FlickrImagesController < ApplicationController
  def index
  end

  def portfolio
    refill_from_flickr
  end

private

  def refill_from_flickr
    FlickRaw.api_key = "07c77887e7450e5d0d86781a7264c45c"
    FlickRaw.shared_secret = "f6e1a90eb6ab7755"


    portfolio_images = flickr.photos.search(:user_id => "80288388@N00", :tags => "glodjib_portfolio")
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
