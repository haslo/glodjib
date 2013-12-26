class AddGalleryModel < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title
      t.string :shorthand
      t.boolean :is_portfolio, :default => false
      t.timestamps
    end

    create_table :galleries_images, :id => false do |t|
      t.integer :gallery_id
      t.integer :image_id
    end
  end
end
