class ImagesController < ApplicationController

  layout 'minimal'

  before_filter :authenticate_user!, :except => [:show]

  expose(:images) { Images::PortfolioService.images_for_portfolio(portfolio) }
  expose(:image) { Image.where(:id => params[:id]).first }
  expose(:previous_image) { portfolio.present? ? images[images.find_index(image) - 1] : nil }
  expose(:next_image) { portfolio.present? ? (images[images.find_index(image) + 1] || images[0]) : nil }
  expose(:portfolio) { params[:portfolio] }

  def show
    redirect_to(root_path) unless image.present?
    @title_parameter = image.image_title
  end

end
