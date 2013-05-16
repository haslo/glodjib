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
    if @admin_password == @admin_password_confirmation
      user = User.first
      user.password = user.password_confirmation = @admin_password
      user.save!
    end
  end

private

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
