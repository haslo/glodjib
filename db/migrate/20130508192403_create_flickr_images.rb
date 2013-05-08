class CreateFlickrImages < ActiveRecord::Migration
  def change
    create_table :flickr_images do |t|
      t.string :flickr_username
      t.string :flickr_id
      t.string :image_title
      t.text :image_description

      t.string :aperture
      t.string :shutter
      t.string :iso
      t.string :focal_length

      t.timestamps
    end
  end
end
