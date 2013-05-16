class Setting < ActiveRecord::Base
  validates_presence_of :key, :value
  validates_uniqueness_of :key

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
