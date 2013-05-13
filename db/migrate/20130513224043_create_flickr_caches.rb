class CreateFlickrCaches < ActiveRecord::Migration
  def change
    create_table :flickr_caches do |t|
      t.integer :flickr_user_id
      t.integer :flickr_tag_id
      t.datetime :timeout

      t.timestamps
    end
  end
end
