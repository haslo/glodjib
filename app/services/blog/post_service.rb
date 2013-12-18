module Blog::PostService
  class << self

    def sanitized_blog_content(post, with_more_content)
      post_content = post.content
      if with_more_content
        post_content = add_images(post_content).gsub(Setting.post_more_separator, "<span id=\"more-#{post.id}\"></span>")
      else
        post_content = add_images(post_content).split(Setting.post_more_separator)[0]
      end
      Nokogiri::HTML::DocumentFragment.parse(post_content.gsub(/<p>(\s|&nbsp;)*<\/p>/, '')).to_html.gsub(/<p>(\s|&nbsp;)*<\/p>/, '').html_safe
    end

    def add_images(post_content)
      %w(left right).each do |position|
        post_content = add_float_images(post_content, position)
      end
      post_content = add_center_images(post_content)
      remove_gallery_tags(post_content)
    end
    private :add_images

    def add_float_images(post_content, position)
      new_post_content = post_content
      post_content.scan(Regexp.new("\\[image#{position}=\\d+\\]")).each do |matching_tag|
        # TODO replace with partial rendering
        flickr_image_id = matching_tag[/\d+/]
        flickr_image_path = Flickr::ImageService.get_url_from_id(flickr_image_id, 'Small 320')
        gallery_page_path = "/image/#{flickr_image_id}" # single_image_flickr_images_path(:id => flickr_image_id)
        float_with_image = "<div class='blog-float-image pull-#{position}'><a href='#{gallery_page_path}'><img src='#{flickr_image_path}'/></a></div><p>"
        new_post_content = new_post_content.gsub(matching_tag, float_with_image)
      end
      new_post_content
    end
    private :add_float_images

    def add_center_images(post_content)
      new_post_content = post_content
      post_content.scan(Regexp.new("\\[imagecenter=.*\\]")).each do |matching_tag|
        # TODO replace with partial rendering
        flickr_image_id = matching_tag[/\d+/]
        flickr_image_path = Flickr::ImageService.get_url_from_id(flickr_image_id, 'Large')
        gallery_page_path = "/image/#{flickr_image_id}" # single_image_flickr_images_path(:id => flickr_image_id)
        center_with_image = "<div class='blog-image-center center-block'><div><a href='#{gallery_page_path}'><img src='#{flickr_image_path}'/></a></div></div><p>"
        new_post_content = new_post_content.gsub(matching_tag, center_with_image)
      end
      new_post_content
    end
    private :add_center_images

    def remove_gallery_tags(post_content)
      post_content.gsub(Regexp.new("\\[gallery=([a-z0-9\\_]+)\\]"), '')
    end

    def portfolio(post_content)
      if post_content =~ Regexp.new("\\[gallery=([a-z0-9\\_]+)\\]")
        $1
      else
        nil
      end
    end

  end
end