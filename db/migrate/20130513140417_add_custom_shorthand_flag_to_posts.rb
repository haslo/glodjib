class AddCustomShorthandFlagToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :custom_shorthand, :boolean, :default => false
  end
end
