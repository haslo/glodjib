class AddDatesToFlickrImage < ActiveRecord::Migration
  def change
    add_column :flickr_images, :date_taken, :datetime
    add_column :flickr_images, :date_posted, :datetime
  end
end
