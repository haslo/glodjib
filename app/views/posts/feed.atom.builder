atom_feed do |feed|
  feed.title(Setting.page_title)
  feed.updated(posts.maximum(:updated_at))
  posts.each do |post|
    feed.entry(post, :url => post_url(:id => post.shorthand)) do |entry|
      entry.title(post.title)
      entry.content(Blog::PostService.sanitized_blog_content(post, false), :type => 'html')
      entry.author do |author|
        author.name(User.first.email)
      end
    end
  end
end