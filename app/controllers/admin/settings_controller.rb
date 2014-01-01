module Admin
  class SettingsController < ApplicationController

    expose(:all_caches) { FlickrCache.all.uniq.sort{|a,b| a.flickr_tag.tag_name <=> b.flickr_tag.tag_name} }
    expose(:caches_to_refresh) { params[:updated_caches].present? ? params[:updated_caches].split(',').map{|cache_id|FlickrCache.find(cache_id)} : [] }

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

  end
end
