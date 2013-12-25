class PortfoliosController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  expose(:portfolio) { params[:portfolio_id] || params[:id] || 'portfolio' }
  expose(:gallery) { Gallery.get_with_id_or_shorthand(portfolio) }
  expose(:images) { gallery.gallery_images.sorted.map(&:image) }

  expose(:caches_present) { all_caches.any? }
  expose(:all_caches) { FlickrCache.all.uniq.sort{|a,b| a.flickr_tag.tag_name <=> b.flickr_tag.tag_name} }
  expose(:caches_to_refresh) { params[:updated_caches].present? ? params[:updated_caches].split(',').map{|cache_id|FlickrCache.find(cache_id)} : [] }

  before_filter :cleanup_caches

  def index
    redirect_to settings_path if all_caches.empty?
  end

  def show
    @title_parameter = [I18n.t('titles.portfolios.portfolio'), gallery.title].uniq.join(': ')
  end

  def reset_cache
    updated_caches = Flickr::CacheService.reset_caches_by_tag(params[:tag])
    flash[:notice] = I18n.t('notices.settings.cache_update_queued')
    redirect_to images_settings_path(:updated_caches => updated_caches.join(','))
  end

  def reset_caches
    updated_caches = Flickr::CacheService.reset_all_caches
    flash[:notice] = I18n.t('notices.settings.cache_update_queued')
    redirect_to images_settings_path(:updated_caches => updated_caches.join(','))
  end

  def destroy_cache
    Flickr::CacheService.destroy_caches_by_tag(params[:tag])
    flash[:notice] = I18n.t('notices.settings.cache_updated')
    redirect_to images_settings_path
  end

  def destroy_caches
    Flickr::CacheService.destroy_all_caches
    flash[:notice] = I18n.t('notices.settings.cache_updated')
    if all_tags_with_caches.empty?
      redirect_to settings_path
    else
      redirect_to images_settings_path
    end
  end

  def cleanup_caches
    Flickr::CacheService.cleanup_caches
  end
  private :cleanup_caches

end
