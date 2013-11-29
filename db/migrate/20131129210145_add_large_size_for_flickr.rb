class AddLargeSizeForFlickr < ActiveRecord::Migration
  def change
    add_column :flickr_images, :flickr_large_url, :string
    add_column :flickr_images, :flickr_id, :string
    FlickrCache.destroy_all
  end
end
