class HomeController < ApplicationController

  layout 'minimal'

  expose(:background_images) do
    # TODO revamp for Galleries
    flickr_cache = Flickr::CacheService.find_or_create_cache(Setting.flickr_front_page_tag)
    flickr_cache.flickr_tag.flickr_images.where(:flickr_user_id => flickr_cache.flickr_user.id)
  end
  expose(:background_image) { background_images.sample }

end
