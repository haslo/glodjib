class GalleriesController < ApplicationController

  expose(:galleries) { Gallery.sorted }
  expose(:gallery) { Gallery.get_with_id_or_shorthand(params[:id]) }
  expose(:images) { gallery.images }

  # TODO revamp and update, the stuff below was copied together from SettingsController and PortfoliosController

  def update
    respond_to do |format|

    end
  end

  def edit
    @title_parameter = portfolio
  end

  def sort
    params['positions'].each do |id, position|
      FlickrImage.where(:id => id).each do |image|
        image.flickr_tag_images.where(:flickr_user => image.flickr_user).each do |tag_link|
          tag_link.position = position
          tag_link.save!
        end
      end
    end
    render :nothing => true
  end

  def check_reset
    flickr_cache = Flickr::APIService.find_or_create_cache(portfolio)
    puts "pending? #{flickr_cache.reset_pending?} (for #{portfolio})"
    render :json => !(flickr_cache.reset_pending?)
  end


  def reset_cache
    updated_caches = Flickr::APIService.reset_caches_by_tag(params[:tag])
    flash[:notice] = I18n.t('notices.settings.cache_update_queued')
    redirect_to images_settings_path(:updated_caches => updated_caches.join(','))
  end

  def reset_caches
    updated_caches = Flickr::APIService.reset_all_caches
    flash[:notice] = I18n.t('notices.settings.cache_update_queued')
    redirect_to images_settings_path(:updated_caches => updated_caches.join(','))
  end

  def destroy_cache
    Flickr::APIService.destroy_caches_by_tag(params[:tag])
    flash[:notice] = I18n.t('notices.settings.cache_updated')
    redirect_to images_settings_path
  end

  def destroy_caches
    Flickr::APIService.destroy_all_caches
    flash[:notice] = I18n.t('notices.settings.cache_updated')
    if all_tags_with_caches.empty?
      redirect_to settings_path
    else
      redirect_to images_settings_path
    end
  end

  def cleanup_caches
    Flickr::APIService.cleanup_caches
  end
  private :cleanup_caches

end
