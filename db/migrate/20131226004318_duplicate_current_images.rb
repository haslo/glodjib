class DuplicateCurrentImages < ActiveRecord::Migration
  def up
    FlickrImage.all.each do |flickr_image|
      puts "doing #{flickr_image.id}"
      image = Image.new
      image.flickr_image = flickr_image
      image.image_title = flickr_image.image_title
      image.save!
    end
  end

  def down
    Image.destroy_all
  end
end
