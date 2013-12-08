class PortfoliosController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  expose(:flickr_images) do
    flickr_cache = Flickr::CacheService.find_or_create_cache(portfolio)
    flickr_cache.flickr_tag.flickr_images.where("flickr_user_id = ?", flickr_cache.flickr_user.id).sorted
  end
  expose(:portfolio) { params[:id] || 'portfolio' }

  def show
    @title_parameter = [I18n.t('titles.portfolios.portfolio'), portfolio.humanize].uniq.join(': ')
  end

  def edit
    @title_parameter = portfolio
  end

  def sort
    # see http://stackoverflow.com/questions/7664317/implement-ajax-sortable-lists-with-jquery-and-rails-3
    raise params.inspect
    render :nothing => true
  end

end
