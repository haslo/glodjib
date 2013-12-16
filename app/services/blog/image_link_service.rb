module Blog::ImageLinkService
  class << self

    def blog_posts_with_images(image_ids)
      filter_by_image_ids(Post.without_pages, image_ids)
    end

    def pages_with_images(image_ids)
      filter_by_image_ids(Post.only_pages, image_ids)
    end

    def filter_by_image_ids(posts, image_ids)
      where_query = Array(image_ids).map do |image_id|
        "(posts.content like '%[image%=#{image_id.to_i}]%')"
      end.join(' or ')
      posts.where(where_query)
    end
    private :filter_by_image_ids

  end
end
