class AddTemporarySettingValues < ActiveRecord::Migration
  def up
    {:flickr_api_key => 'api key', :flickr_shared_secret => 'shared secret', :page_title => 'page title', :post_more_separator => '!!more!!'}.each do |key, value|
      Setting.put(key, value)
    end
  end

  def down
    Setting.destroy_all
  end
end
