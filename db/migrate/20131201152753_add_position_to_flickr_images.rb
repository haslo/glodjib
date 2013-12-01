class AddPositionToFlickrImages < ActiveRecord::Migration
  def up
    add_column :flickr_images, :position, :integer
    FlickrImage.reset_column_information
    FlickrImage.all.order(:flickr_id).each_with_index do |image, index|
      image.position = index
      image.save!
    end
  end

  def down
    remove_column :flickr_images, :position
  end
end
