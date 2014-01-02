module Admin
  class GalleriesController < ApplicationController

    expose(:galleries) { Gallery.sorted }
    expose(:gallery, :attributes => :gallery_params) { Gallery.get_with_id_or_shorthand(params[:gallery_id] || params[:id]) }
    expose(:images) { gallery.gallery_images.sorted.map(&:image) }

    def edit
      @title_parameter = gallery.title
    end

    def update
      respond_to do |format|
        if gallery.update_attributes(params[:user])
          format.json { respond_with_bip(gallery) }
        else
          format.json { respond_with_bip(gallery) }
        end
      end
    end

    def reorder
      params['positions'].each do |id, position|
        puts "at position #{position}"
        Image.where(:id => id).each do |image|
          puts "image #{image} with id #{id}"
          image.gallery_images.where(:gallery_id => gallery.id).each do |gallery_image|
            gallery_image.position = position
            gallery_image.save!
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


    def gallery_params
      params.require(:gallery).permit(:title, :shorthand, :is_portfolio)
    end
    private :gallery_params

  end
end
