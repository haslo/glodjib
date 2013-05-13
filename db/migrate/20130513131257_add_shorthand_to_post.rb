class AddShorthandToPost < ActiveRecord::Migration
  def change
    add_column :posts, :shorthand, :string
  end
end
