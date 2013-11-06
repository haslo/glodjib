class RenameHabtm < ActiveRecord::Migration
  def change
    rename_table :flickr_images_flickr_tags, :flickr_images_tags
  end
end
