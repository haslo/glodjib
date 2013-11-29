class AddLargeSizeForFlickr < ActiveRecord::Migration
  def change
    add_column :flickr_images, :flickr_large_url, :string
    FlickrCache.destroy_all
  end
end
