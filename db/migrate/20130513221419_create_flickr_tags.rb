class CreateFlickrTags < ActiveRecord::Migration
  def change
    create_table :flickr_tags do |t|
      t.text :tag_name

      t.timestamps
    end

    create_table :flickr_images_flickr_tags do |t|
      t.integer :flickr_image_id
      t.integer :flickr_tag_id

      t.timestamps
    end
  end
end
