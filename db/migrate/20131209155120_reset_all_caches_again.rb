class ResetAllCachesAgain < ActiveRecord::Migration
  def up
    FlickrCache.all.each do |flickr_cache|
      Flickr::CacheService.reset_cache(flickr_cache)
    end
  end

  def down
    # noop
  end
end
