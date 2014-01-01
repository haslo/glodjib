class PortfoliosController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  expose(:portfolio) { params[:portfolio_id] || params[:id] || 'portfolio' }
  expose(:gallery) { Gallery.get_with_id_or_shorthand(portfolio) }
  expose(:images) { gallery.gallery_images.sorted.map(&:image) }

  def show
    @title_parameter = [I18n.t('titles.portfolios.portfolio'), portfolio.humanize].uniq.join(': ')
  end

end
