class Setting < ActiveRecord::Base
  validates_presence_of :key, :value
  validates_uniqueness_of :key

  def self.put(key, value)
    setting = Setting.where("`key` = ?", key).first_or_initialize
    setting.key = key
    setting.value = value
    setting.save!
    value
  end

  def self.get(key)
    settings = Setting.where("`key` = ?", key)
    if settings.count > 0
      settings.first.value
    else
      nil
    end
  end
end
