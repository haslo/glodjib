module Images::GalleryLinkService
  class << self

    def images_for_gallery(portfolio)
      gallery = Gallery.get_with_id_or_shorthand(portfolio)
      gallery.gallery_images.sorted.map(&:image)
    end

    def portfolios_for_image(image)
      image.galleries.only_portfolios.sorted
    end

    def post_portfolio_links(image)
      portfolio_links(image, Post.without_pages)
    end

    def page_portfolio_links(image)
      portfolio_links(image, Post.only_pages)
    end

    def portfolio_links(image, post_scope = Post)
      posts = []
      portfolios_for_image(image).each do |portfolio|
        posts += posts_with_gallery(portfolio, post_scope)
      end
      posts.uniq.sort{|a,b| a.title <=> b.title}
    end

    def posts_with_gallery(gallery, post_scope = Post)
      [
        post_scope.where("content like '%gallery=#{gallery.shorthand}%'").all,
        post_scope.where("content like '%gallery=#{gallery.id}%'").all
      ].flatten
    end

  end
end