class PortfoliosController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  expose(:flickr_images) do
    flickr_cache = Flickr::CacheService.find_or_create_cache(portfolio)
    flickr_cache.flickr_tag.flickr_tag_images.where(:flickr_user_id => flickr_cache.flickr_user.id).sorted.map(&:flickr_image)
  end
  expose(:portfolio) { params[:id] || 'portfolio' }

  def show
    @title_parameter = [I18n.t('titles.portfolios.portfolio'), portfolio.humanize].uniq.join(': ')
  end

  def edit
    @title_parameter = portfolio
  end

  def sort
    params['positions'].each do |id, position|
      FlickrImage.where(:id => id).each do |image|
        image.position = position
        image.save!
      end
    end
    render :nothing => true
  end

end