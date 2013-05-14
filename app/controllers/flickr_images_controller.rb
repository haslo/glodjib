class FlickrImagesController < ApplicationController
  def portfolio
    FlickrAPI.new.update_cache_for_tag('portfolio')
  end
end
