class ResetAllFlickrTables < ActiveRecord::Migration
  def up
    %w(flickr_images flickr_images_tags flickr_users flickr_tags flickr_image_sizes flickr_caches).each do |table_name|
      ActiveRecord::Base.connection.execute("delete from #{table_name}")
    end
  end

  def down
    # noop
  end
end
