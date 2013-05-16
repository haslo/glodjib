class SettingsController < ApplicationController
  def index
    if request.post?
      valid_keys = %w(flickr_user flickr_api_key flickr_shared_secret page_title post_more_separator)
      if params.keys.include?("setting") && valid_keys.collect{|key| params["setting"].keys.include?(key) && !params["setting"][key].blank?}.all?
        valid_keys.each do |key|
          Setting.put(key, params["setting"][key])
        end
        setting = Setting.new
        setting.admin_password = params["setting"]["admin_password"]
        setting.admin_password_confirmation = params["setting"]["admin_password_confirmation"]
        flash[:error] = setting.save_admin_password
      else
        flash[:error] = I18n.t('notices.settings.invalid_settings')
      end
    end
  end
end
