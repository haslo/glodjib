class UpdateBlogPostImageLinks < ActiveRecord::Migration
  def up
    Post.all.each do |post|
      new_content = post.content
      post.content.scan(/=(\d+)\]/).each do |image_match|
        flickr_image = FlickrImage.find($1.to_i)
        new_content = new_content.gsub("=#{flickr_image.id}]", "=#{flickr_image.image.id}]")
      end
      post.content = new_content
      post.save!
    end
  end

  def down
    # noop
  end
end
