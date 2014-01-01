class ChangeFlickrUserInFlickrImage < ActiveRecord::Migration
  def change
    remove_column :flickr_images, :flickr_user_id, :integer
    add_column :flickr_images, :flickr_user, :string
    # potentially lossy, but let's ignore that
    ActiveRecord::Base.connection.execute("update flickr_images set flickr_user = '#{Flickr::ParameterService.flickr_user}'")
  end
end
