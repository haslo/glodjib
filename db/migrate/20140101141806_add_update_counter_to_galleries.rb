class AddUpdateCounterToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :pending_updates, :integer, :default => 0, :null => false
  end
end
