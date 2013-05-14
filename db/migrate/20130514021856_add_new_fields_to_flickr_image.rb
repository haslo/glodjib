class AddNewFieldsToFlickrImage < ActiveRecord::Migration
  def change
    add_column :flickr_images, :camera, :string
    add_column :flickr_images, :full_flickr_url, :string
    add_column :flickr_images, :flickr_thumbnail_url, :string
  end
end
