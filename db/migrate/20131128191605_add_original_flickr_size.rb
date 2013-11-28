class AddOriginalFlickrSize < ActiveRecord::Migration
  def change
    add_column :flickr_images, :flickr_original_url, :string
  end
end
