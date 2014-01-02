class CreateGalleriesFromFlickrCaches < ActiveRecord::Migration
  def up
    add_column :galleries, :custom_shorthand, :boolean, :default => false
    # note: all sort orders are not updated yet because the link table doesn't have a position yet
    FlickrCache.all.each do |flickr_cache|
      tag_name = flickr_cache.flickr_tag.tag_name
      gallery = Gallery.new
      gallery.shorthand = tag_name
      gallery.title = tag_name.humanize
      gallery.is_portfolio = Setting.portfolio_tags.present? && Setting.portfolio_tags.include?(tag_name)
      gallery.save!
      flickr_cache.flickr_tag.flickr_images.map(&:image).uniq.each do |image|
        gallery.images << image
      end
    end
  end

  def down
    remove_column :galleries, :custom_shorthand
  end
end
