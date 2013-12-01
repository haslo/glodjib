class AddFlickrSizes < ActiveRecord::Migration
  def change
    remove_column :flickr_images, :flickr_thumbnail_url
    remove_column :flickr_images, :flickr_large_url
    remove_column :flickr_images, :flickr_original_url

    create_table :flickr_image_sizes do |t|
      t.integer :flickr_image_id
      t.string :label
      t.integer :width
      t.integer :height
      t.string :source
      t.string :url
      t.string :media
      t.timestamps
    end

    FlickrTag.destroy_all
  end
end
