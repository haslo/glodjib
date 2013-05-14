class FixHabtmForTagsAndImages < ActiveRecord::Migration
  def up
    remove_column :flickr_images_flickr_tags, :id
    remove_column :flickr_images_flickr_tags, :created_at
    remove_column :flickr_images_flickr_tags, :updated_at
  end

  def down
    add_column :flickr_images_flickr_tags, :id, :primary_key
    add_column :flickr_images_flickr_tags, :created_at, :datetime
    add_column :flickr_images_flickr_tags, :updated_at, :datetime
  end
end
