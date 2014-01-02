module Admin
  class GalleriesController < ApplicationController

    before_filter :authenticate_user!

    expose(:galleries) { Gallery.sorted }
    expose(:gallery, :attributes => :gallery_params) { Gallery.get_with_id_or_shorthand(params[:gallery_id] || params[:id]) }
    expose(:images) { gallery.gallery_images.sorted.map(&:image) }

    def edit
      @title_parameter = gallery.title
    end

    def update
      respond_to do |format|
        if gallery.update(gallery_params)
          format.json { respond_with_bip(gallery) }
        else
          format.json { respond_with_bip(gallery) }
        end
      end
    end

    def destroy
      gallery.destroy
      redirect_to :action => :index
    end

    def reorder_galleries
      params['positions'].each do |id, position|
        Gallery.find(id).tap do |gallery|
          gallery.position = position
          gallery.save!
        end
      end
      render :nothing => true
    end

    def reorder_images
      params['positions'].each do |id, position|
        Image.find(id).tap do |image|
          image.gallery_images.where(:gallery_id => gallery.id).each do |gallery_image|
            gallery_image.position = position
            gallery_image.save!
          end
        end
      end
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
