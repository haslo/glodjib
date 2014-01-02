class ApplicationController < ActionController::Base

  protect_from_forgery(:with => :exception)
  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  expose(:displayed_portfolios) { Gallery.only_portfolios.sorted }

end
