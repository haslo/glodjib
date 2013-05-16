class RemoveFlickrConfigSettings < ActiveRecord::Migration
  def up
    Setting.destroy_all
    Setting.page_title = "the glodjib platform"
    Setting.post_more_separator = "!!more!!"
  end

  def down
    Setting.destroy_all
  end
end
