module Admin
  class ImagesController < ApplicationController

    before_filter :authenticate_user!

    expose(:new_image) { Image.new }

  end
end
