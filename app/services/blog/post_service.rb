module Blog::PostService
  class << self

    def sanitized_blog_content(post, with_more_content)
      if with_more_content
        add_images(post.content).gsub(Setting.post_more_separator, "<span id=\"more-#{post.id}\"></span>").html_safe
      else
        Nokogiri::HTML::DocumentFragment.parse(add_images(post.content).split(Setting.post_more_separator)[0]).to_html.html_safe
      end
    end

    def add_images(post_content)
      %w(left right).each do |position|
        post_content = add_float_images(post_content, position)
      end
      add_center_images(post_content)
    end
    private :add_images

    def add_float_images(post_content, position)
      new_post_content = post_content
      post_content.scan(Regexp.new("\\[image#{position}=\\d+\\]")).each do |matching_tag|
        # TODO replace with partial rendering
        flickr_image_id = matching_tag[/\d+/]
        flickr_image_path = Flickr::ImageService.get_blog_post_image_url(flickr_image_id)
        gallery_page_path = "/gallery/view/#{flickr_image_id}" # single_image_flickr_images_path(:id => flickr_image_id)
        float_with_image = "<div class='pull-#{position}'><a href='#{gallery_page_path}#full_image'><img src='#{flickr_image_path}'/></a></div>"
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
        flickr_image_path = Flickr::ImageService.get_blog_post_image_url(flickr_image_id)
        gallery_page_path = "/gallery/view/#{flickr_image_id}" # single_image_flickr_images_path(:id => flickr_image_id)
        center_with_image = "<div class='center-block'><div><a href='#{gallery_page_path}#full_image'><img src='#{flickr_image_path}'/></a></div></div>"
        new_post_content = new_post_content.gsub(matching_tag, center_with_image)
      end
      Nokogiri::HTML::DocumentFragment.parse(new_post_content).to_html.gsub('<p></p>', '')
    end
    private :add_center_images

  end
end