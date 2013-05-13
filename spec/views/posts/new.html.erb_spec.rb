require 'spec_helper'

describe "posts/new.html.erb" do
  before(:each) do
    @post = Post.new(:title => "title of the post", :content => "content of the post")
  end

  it "should contain title of the post" do
    render
    response.should have_selector("input", :type => "text", :name => "post[title]", :value => @post.title)
  end

  it "should contain content of the post" do
    render
    response.should contain(@post.content)
  end
end
