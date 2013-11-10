require 'spec_helper'

describe "posts/show.html.haml" do
  before(:each) do
    @post = Post.create!(:title => "title of the post 1", :content => "<p>content of the post 1!!more!!<strong>new</strong> 1 content after the split</p>")
    view.stub(:post) { @post }
    view.stub(:post_comment) { PostComment.new }
    Setting.post_more_separator = "!!more!!"
  end

  it "should not contain title of the post, because the layout does contain it" do
    render
    response.should_not contain(@post.title)
  end

  it "should contain date of the post in short format" do
    render
    response.should contain(I18n.l(@post.created_at, :format => :short))
  end

  it "should contain content of the post, with !!more!! replaced" do
    render
    response.should contain(Nokogiri::HTML::DocumentFragment.parse(@post.content.gsub('!!more!!', '')).text)
  end

  it "should have HTML tags in the post content" do
    render
    response.should_not contain('<strong>')
    response.should_not contain('<p>')
  end

  it "should not have missing translations" do
    render
    response.should_not contain("translation missing")
  end
end
