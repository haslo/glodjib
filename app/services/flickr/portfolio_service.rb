module Flickr::PortfolioService
  class << self

    def images_for_portfolio(portfolio)
      flickr_cache = Flickr::CacheService.find_or_create_cache(portfolio)
      flickr_cache.flickr_tag.flickr_tag_images.where(:flickr_user_id => flickr_cache.flickr_user.id).sorted.map(&:flickr_image)
    end

  end
end