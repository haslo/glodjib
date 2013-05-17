class CreatePostComments < ActiveRecord::Migration
  def change
    create_table :post_comments do |t|
      t.integer :post_id

      t.string :name
      t.string :comment
      t.string :email
      t.string :url

      t.timestamps
    end
  end
end
