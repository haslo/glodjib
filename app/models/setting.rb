class Setting < ActiveRecord::Base
  validates_presence_of :key, :value
  validates_uniqueness_of :key

  def method_missing(message, *args, &block)
    Setting.method_missing(message, *args, &block)
  end

  def self.method_missing(message, *args, &block)
    if message.to_s =~ /([a-z_]+)=/
      return put($1, args[0])
    elsif message.to_s =~ /([a-z_]+)/
      return get(message)
    end
    super
  end

  def admin_password=(value)
    @admin_password = value
  end

  def admin_password_confirmation=(value)
    @admin_password_confirmation = value
  end

  def save_admin_password
    unless @admin_password.blank? || @admin_password_confirmation.blank?
      user = User.first
      user.password = @admin_password
      user.password_confirmation = @admin_password_confirmation
      unless user.save
        user.errors[:password][0]
      end
    end
  end

  def self.put(key, value)
    setting = Setting.where("`key` = ?", key.to_s).first_or_initialize
    setting.key = key.to_s
    setting.value = value.to_s
    setting.save!
    value.to_s
  end

  def self.get(key)
    settings = Setting.where("`key` = ?", key.to_s)
    if settings.count > 0
      settings.first.value
    else
      nil
    end
  end
end
