module Flickr::ParameterService
  class << self

    def api_key
      @api_key ||= Setting.flickr_api_key
    end

    def shared_secret
      @shared_secret ||= Setting.flickr_shared_secret
    end

    def flickr_user
      @flickr_username ||= Setting.flickr_user
    end

  end
end