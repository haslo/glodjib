class SettingsController < ApplicationController
  def index
  end

  def update_all
    valid_keys = %w(flickr_api_key flickr_shared_secret page_title post_more_separator)
    if params.keys.include?("setting") && valid_keys.collect{|key| params["setting"].keys.include?(key) && !params["setting"][key].blank?}.all?
      valid_keys.each do |key|
        Setting.put(key, params["setting"][key])
      end
    else
      flash[:error] = I18n.t('notices.settings.invalid_settings')
    end
    redirect_to settings_path
  end
end
