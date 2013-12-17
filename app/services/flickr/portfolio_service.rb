module Flickr::PortfolioService
  class << self

    def images_for_portfolio(portfolio)
      flickr_cache = Flickr::CacheService.find_or_create_cache(portfolio)
      flickr_cache.flickr_tag.flickr_tag_images.where(:flickr_user_id => flickr_cache.flickr_user.id).sorted.map(&:flickr_image)
    end

    def portfolios_for_image(flickr_image)
      portfolios = []
      flickr_image.flickr_tags.map(&:tag_name).each do |portfolio|
        flickr_cache = Flickr::CacheService.find_cache(portfolio)
        if flickr_cache.present? && (portfolio == 'portfolio' || Setting.portfolio_tags =~ Regexp.new(portfolio))
          portfolios << portfolio
        end
      end
      portfolios.uniq.sort
    end

    def posts_with_portfolio_for_image(flickr_image)
      posts = []
      flickr_image.flickr_tags.map(&:tag_name).each do |portfolio|
        flickr_cache = Flickr::CacheService.find_cache(portfolio)
        if flickr_cache.present?
          posts += Post.without_pages.where("content like '%gallery=#{portfolio}%'").all
        end
      end
      posts.uniq.sort{|a,b| a.title <=> b.title}
    end

    def pages_with_portfolio_for_image(flickr_image)
      pages = []
      flickr_image.flickr_tags.map(&:tag_name).each do |portfolio|
        flickr_cache = Flickr::CacheService.find_cache(portfolio)
        if flickr_cache.present?
          pages += Post.only_pages.where("content like '%gallery=#{portfolio}%'").all
        end
      end
      pages.uniq.sort{|a,b| a.title <=> b.title}
    end

  end
end