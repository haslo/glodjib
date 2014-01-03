module Admin
  class GalleriesController < ApplicationController

    before_filter :authenticate_user!

    expose(:galleries) { Gallery.sorted }
    expose(:gallery, :attributes => :gallery_params) { Gallery.get_with_id_or_shorthand(params[:gallery_id] || params[:id]) || Gallery.new }
    expose(:images) { gallery.gallery_images.sorted.map(&:image) }

    def create
      if gallery.update(gallery_params)
        if gallery.flickr_tag.present?
          ActiveRecord::Base.transaction do
            target_gallery.pending_updates += 1
            target_gallery.save
          end
          QC.enqueue('Flickr::APIService.fetch_images_by_tag', gallery.id, gallery.flickr_tag)
        end
        redirect_to :action => :index
      else
        render :new
      end
    end

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

    def add_images
      if request.post? && params[:flickr_tag].present? || params[:flickr_id].present?
        ActiveRecord::Base.transaction do
          gallery.pending_updates += 1
          gallery.save
        end
        if params[:flickr_tag].present?
          QC.enqueue('Flickr::APIService.fetch_images_by_tag', gallery.id, params[:flickr_tag])
        end
        if params[:flickr_id].present?
          QC.enqueue('Flickr::APIService.fetch_image_by_id', gallery.id, params[:flickr_id])
        end
        redirect_to :action => :index
      end
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
      render :json => (gallery.pending_updates <= 0)
    end


    def gallery_params
      params.require(:gallery).permit(:title, :shorthand, :is_portfolio, :flickr_tag)
    end
    private :gallery_params

  end
end
