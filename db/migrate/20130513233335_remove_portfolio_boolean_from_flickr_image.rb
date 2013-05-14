class RemovePortfolioBooleanFromFlickrImage < ActiveRecord::Migration
  def up
    remove_column :flickr_images, :is_in_portfolio
  end

  def down
    add_column :flickr_images, :is_in_portfolio, :boolean
  end
end
