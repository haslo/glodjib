class AddSpecialUsageFieldToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :special_usage, :string

    Gallery.reset_column_information

    Gallery.where(:shorthand => Setting.flickr_front_page_tag).each do |frontpage_gallery|
      frontpage_gallery.special_usage = 'frontpage'
      frontpage_gallery.save!
    end
  end
end
