require 'spec_helper'

describe "post_tag/show.html.erb" do
  before(:each) do
    @post_tag = PostTag.create!(:tag_text => "tag_text")
    @post_tag.posts << Post.create!(:title => "title of the post 1", :content => "<p>content of the post 1!!more!!<strong>new</strong> 1 content after the split</p>")
    @post_tag.posts << Post.create!(:title => "title of the post 2", :content => "<p>content of the post 2!!more!!<strong>new</strong> 2 content after the split</p>")
    @posts = @post_tag.posts
    view.stub(:user_signed_in?) { true }
  end

  it "should contain titles of all posts" do
    render
    @posts.each do |post|
      response.should contain(post.title)
    end
  end

  it "should contain dates of all posts in short format" do
    render
    @post_tag.posts.each do |post|
      response.should contain(I18n.l(post.created_at, :format => :short))
    end
  end

  it "should contain trimmed contents of all posts" do
    render
    @post_tag.posts.each do |post|
      response.should contain(Nokogiri::HTML::DocumentFragment.parse(post.content.split('!!more!!')[0]).text)
    end
  end

  it "should not contain any trimming tags ('!!more!!')" do
    render
    response.should_not contain('!!more!!')
  end

  it "should not contain untrimmed contents of any posts" do
    render
    @post_tag.posts.each do |post|
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
