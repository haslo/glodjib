class AddIsSpamToPostComment < ActiveRecord::Migration
  def change
    add_column :post_comments, :is_spam, :boolean, :default => false
    add_column :post_comments, :is_deleted, :boolean, :default => false
  end
end
