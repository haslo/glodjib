require 'spec_helper'

describe "posts/show.html.erb" do
  before(:each) do
    @post = Post.new(:title => "title of the post", :content => "content of the post")
    @post.created_at = Time.now
  end

  it "should not contain title of the post, because the layout does contain it" do
    render
    response.should_not contain(@post.title)
  end

  it "should contain date of the post in short format" do
    render
    response.should contain(I18n.l(@post.created_at, :format => :short))
  end

  it "should contain content of the post" do
    render
    response.should contain(@post.content)
  end
end
