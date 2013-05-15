class CreatePostTags < ActiveRecord::Migration
  def change
    create_table :post_tags do |t|
      t.string :tag_text

      t.timestamps
    end

    create_table :post_tags_posts, :id => false do |t|
      t.integer :post_id
      t.integer :post_tag_id
    end
  end
end
