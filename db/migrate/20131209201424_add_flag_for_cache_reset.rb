class AddFlagForCacheReset < ActiveRecord::Migration
  def change
    add_column :flickr_caches, :reset_pending, :boolean, :default => false
  end
end
