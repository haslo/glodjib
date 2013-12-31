class MovePositionsFromTagsToGalleries < ActiveRecord::Migration

  def change

    add_column :galleries_images, :id, :primary_key
    add_column :galleries_images, :position, :integer
    add_column :galleries_images, :created_at, :datetime
    add_column :galleries_images, :updated_at, :datetime

    add_column :galleries, :position, :integer

    reversible do |dir|
      dir.up do
        FlickrTagImage.all.each do |flickr_tag_image|
          gallery = Gallery.get_with_id_or_shorthand(flickr_tag_image.flickr_tag.tag_name)
          if gallery.present?
            image = flickr_tag_image.flickr_image.image
            gallery_image = GalleryImage.where(:gallery_id => gallery.id).where(:image_id => image.id).first
            gallery_image.position = flickr_tag_image.position
            gallery_image.save!
          end
        end
      end
    end

    drop_table :flickr_tags
    drop_table :flickr_tag_images
    drop_table :flickr_caches
    drop_table :flickr_users

  end

end
