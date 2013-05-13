class CreateFlickrUsers < ActiveRecord::Migration
  def change
    create_table :flickr_users do |t|
      t.text :username

      t.timestamps
    end

    add_column :flickr_images, :flickr_user_id, :integer
  end
end
