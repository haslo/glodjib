module Admin
  class GalleriesController < ApplicationController

    expose(:galleries) { Gallery.sorted }
    expose(:gallery) { Gallery.get_with_id_or_shorthand(params[:id]) }
    expose(:images) { gallery.images }

    # TODO implement RESTful actions, including JSON responses for BestInPlace

    def update
      respond_to do |format|
        # TODO add responses
      end
    end

    def edit
      @title_parameter = gallery.title
    end

    def reorder
      params['positions'].each do |id, position|
        FlickrImage.where(:id => id).each do |image|
          image.flickr_tag_images.where(:flickr_user => image.flickr_user).each do |tag_link|
            tag_link.position = position
            tag_link.save!
          end
        end
      end
      # TODO add return value in JSON
      render :nothing => true
    end

    def is_updated
      # TODO add context for JSON
      render :json => (gallery.pending_updates <= 0)
    end

  end
end
