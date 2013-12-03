class RemoveTimeoutField < ActiveRecord::Migration
  def change
    remove_column :flickr_caches, :timeout
  end
end
