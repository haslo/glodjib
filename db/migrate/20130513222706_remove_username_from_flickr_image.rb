class RemoveUsernameFromFlickrImage < ActiveRecord::Migration
  def up
    remove_column :flickr_images, :flickr_username
  end

  def down
    add_column :flickr_images, :flickr_username, :text
  end
end
