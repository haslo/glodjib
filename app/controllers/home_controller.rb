class HomeController < ApplicationController

  layout 'minimal'
  expose(:background_image) { FlickrImage.find(Setting.front_page_image) }

end
