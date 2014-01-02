class AddFlickrTagToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :flickr_tag, :string
    ActiveRecord::Base.connection.execute 'update galleries set flickr_tag = shorthand'
  end
end
