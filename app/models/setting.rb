class Setting < ActiveRecord::Base

  validates :key, :presence => true, :uniqueness => true

  # TODO improve key handling, maybe with a service?
  MANDATORY_KEYS =  %w(page_title_short page_title flickr_user flickr_api_key flickr_shared_secret flickr_front_page_tag flickr_blog_images_tag post_more_separator)
  STANDARD_KEYS =  %w(page_title_short page_title tagline posts_per_page flickr_user flickr_api_key flickr_shared_secret flickr_front_page_tag flickr_blog_images_tag portfolio_tags post_more_separator akismet_key disqus_shortname flickr_url twitter_url facebook_url google_plus_url)
  KEYS_WITH_DEFAULT = %w(flickr_user flickr_api_key flickr_shared_secret flickr_front_page_tag flickr_blog_images_tag)
  KEYS_FOR_AUTHENTICATION = %w(admin_password admin_password_confirmation)

  def self.singleton
    Setting.where(:key => 'singleton').first_or_create
  end

  def method_missing(message, *args, &block)
    case message.to_s
      when /^(key|value)=$/
        write_attribute($1, args[0])
      when /^(key|value)$/
        read_attribute($1)
      else
        Setting.method_missing(message, *args, &block)
    end
  end

  def self.method_missing(message, *args, &block)
    case message.to_s
      when /^([a-z_]+)=$/
        return put($1, args[0])
      when /^([a-z_]+)$/
        return get(message) if get(message).present?
        if KEYS_WITH_DEFAULT.include?(message.to_s)
          return put(message, FLICKR_CONFIG[message[7..message.length]])
        end
        return nil
      else
        super
    end
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
        [
          Array(user.errors[:password]).join(', '),
          Array(user.errors[:password_confirmation]).join(', ')
        ].compact.join(', ')
      end
    end
  end

  def self.put(key, value)
    setting = Setting.where(:key => key.to_s).first_or_initialize
    setting.key = key.to_s
    setting.value = value.to_s
    setting.save!
    value.to_s
  end

  def self.get(key)
    settings = Setting.where(:key => key.to_s)
    if settings.count > 0
      settings.first.value
    else
      nil
    end
  end

end
