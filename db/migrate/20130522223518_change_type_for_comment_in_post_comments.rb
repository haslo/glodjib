class ChangeTypeForCommentInPostComments < ActiveRecord::Migration
  def up
    change_column :post_comments, :comment, :text
  end

  def down
    change_column :post_comments, :comment, :string
  end
end
