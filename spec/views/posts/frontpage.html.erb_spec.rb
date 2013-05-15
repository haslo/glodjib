require 'spec_helper'

describe "posts/frontpage.html.erb" do
  before(:each) do
    @posts = [ Post.create!(:title => "title of the post 1", :content => "<p>content of the post 1!!more!!<strong>new</strong> 1 content after the split</p>"),
               Post.create!(:title => "title of the post 2", :content => "<p>content of the post 2!!more!!<strong>new</strong> 2 content after the split</p>") ]
  end

  it "should contain titles of all posts" do
    render
    @posts.each do |post|
      response.should contain(post.title)
    end
  end

  it "should contain dates of all posts in short format" do
    render
    @posts.each do |post|
      response.should contain(I18n.l(post.created_at, :format => :short))
    end
  end

  it "should contain trimmed contents of all posts" do
    render
    @posts.each do |post|
      response.should contain(Nokogiri::HTML::DocumentFragment.parse(post.content.split('!!more!!')[0]).text)
    end
  end

  it "should not contain any trimming tags ('!!more!!')" do
    render
    response.should_not contain('!!more!!')
  end

  it "should not contain untrimmed contents of any posts" do
    render
    @posts.each do |post|
      response.should_not contain(Nokogiri::HTML::DocumentFragment.parse(post.content.split('!!more!!')[1]).text)
    end
  end

  it "should have HTML tags in the post content" do
    render
    response.should_not contain('<')
    response.should_not contain('>')
  end

  it "should not have missing translations" do
    render
    response.should_not contain("translation missing")
  end
end
