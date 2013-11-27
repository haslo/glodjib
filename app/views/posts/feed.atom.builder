atom_feed do |feed|
  feed.title = Setting.page_title
  feed.updated posts.maximum(:updated_at)
  posts.each do |post|
    feed.entry(post, :url => "#{root_url}#{post.shorthand}") do |entry|
      entry.title(post.title)
      entry.content(Nokogiri::HTML::DocumentFragment.parse(post.content.split(Setting.post_more_separator)[0]).to_html.html_safe, :type => 'html')
      entry.url("#{root_url}#{post.shorthand}")
      #entry.author do |author|
      #  author.name post.author # TODO add
      #end
    end
  end
end