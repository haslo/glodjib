class ChangeFlickrImagesOwnership < ActiveRecord::Migration

  def change
    add_column :flickr_images_tags, :id, :primary_key
    add_column :flickr_images_tags, :created_at, :datetime
    add_column :flickr_images_tags, :updated_at, :datetime
    add_column :flickr_images_tags, :position, :integer
    add_column :flickr_images_tags, :flickr_user_id, :integer

    rename_table :flickr_images_tags, :flickr_tag_images

    remove_column :flickr_images, :position, :integer
    remove_column :flickr_images, :flickr_user_id, :integer

    reversible do |dir|
      dir.up do
        %w(flickr_images flickr_tag_images flickr_users flickr_tags flickr_image_sizes flickr_caches).each do |table_name|
          ActiveRecord::Base.connection.execute("delete from #{table_name}")
        end
      end
    end
  end

end
