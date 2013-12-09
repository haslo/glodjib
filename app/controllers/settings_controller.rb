class SettingsController < ApplicationController

  expose(:all_caches) { FlickrCache.all.uniq.sort{|a,b| a.flickr_tag.tag_name <=> b.flickr_tag.tag_name} }
  expose(:caches_to_refresh) { params[:updated_caches].present? ? params[:updated_caches].split(',').map{|cache_id|FlickrCache.find(cache_id)} : [] }

  before_filter :cleanup_caches

  def index
    redirect_to :action => :parameters
  end

  def images
    redirect_to settings_path if all_caches.empty?
  end

  def update
    valid_keys = Setting::STANDARD_KEYS
    errors = []
    if params.keys.include?("setting") && Setting::MANDATORY_KEYS.collect{|key| params["setting"].keys.include?(key) && !params["setting"][key].blank?}.all?
      valid_keys.each do |key|
        Setting.put(key, params["setting"][key] || '')
      end
      setting = Setting.new
      if params['setting']['akismet_key'].present?
        setting.akismet_key = params['setting']['akismet_key']
      end
      setting.admin_password = params['setting']['admin_password']
      setting.admin_password_confirmation = params['setting']['admin_password_confirmation']
      errors << setting.save_admin_password
    else
      errors << I18n.t('notices.settings.invalid_settings')
    end
    if errors.empty?
      flash[:notice] = I18n.t('notices.settings.saved')
    else
      flash[:error] = errors.join(', ')
    end
    redirect_to :action => :index
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
