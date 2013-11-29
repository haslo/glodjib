class HomeController < ApplicationController

  layout 'minimal'

  def flickr_tag_for_background
    Setting.flickr_front_page_tag
  end

end
