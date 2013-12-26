class AddImageModels < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string   'image_title'
      t.text     'image_description'
      t.string   'aperture'
      t.string   'shutter'
      t.string   'iso'
      t.string   'focal_length'
      t.string   'camera'
      t.datetime 'date_taken'
      t.integer  'flickr_image_id'

      t.timestamps
    end

    rename_table :flickr_image_sizes, :image_sizes
    rename_column :image_sizes, :flickr_image_id, :linked_image_id
    add_column :image_sizes, :linked_image_type, :string

    ImageSize.reset_column_information
    ImageSize.all.each do |image_size|
      image_size.linked_image_type = FlickrImage.to_s
      image_size.save!
    end
  end
end
