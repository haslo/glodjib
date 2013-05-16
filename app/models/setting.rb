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
