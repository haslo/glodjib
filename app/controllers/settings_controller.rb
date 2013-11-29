class SettingsController < ApplicationController

  def create
    valid_keys = Setting::STANDARD_KEYS
    errors = []
    if params.keys.include?("setting") && valid_keys.collect{|key| params["setting"].keys.include?(key) && !params["setting"][key].blank?}.all?
      valid_keys.each do |key|
        Setting.put(key, params["setting"][key])
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
