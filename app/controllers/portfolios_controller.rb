class PortfoliosController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  expose(:images) { Images::PortfolioService.images_for_portfolio(portfolio) }
  expose(:portfolio) { (params[:id].present? ? params[:id] : params[:portfolio_id]) || 'portfolio' }

  def show
    @title_parameter = [I18n.t('titles.portfolios.portfolio'), portfolio.humanize].uniq.join(': ')
  end

  def edit
    @title_parameter = portfolio
  end

  def sort
    params['positions'].each do |id, position|
      FlickrImage.where(:id => id).each do |image|
        image.flickr_tag_images.where(:flickr_user => image.flickr_user).each do |tag_link|
          tag_link.position = position
          tag_link.save!
        end
      end
    end
    render :nothing => true
  end

  def check_reset
    flickr_cache = Flickr::CacheService.find_or_create_cache(portfolio)
    puts "pending? #{flickr_cache.reset_pending?} (for #{portfolio})"
    render :json => !(flickr_cache.reset_pending?)
  end

end
