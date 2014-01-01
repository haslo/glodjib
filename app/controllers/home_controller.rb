class HomeController < ApplicationController

  layout 'minimal'

  expose(:background_images) do
    images = []
    Gallery.with_special_usage('frontpage').each do |frontpage_gallery|
      images += frontpage_gallery.images
    end
    images
  end
  expose(:background_image) { background_images.sample }

end
