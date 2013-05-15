require 'spec_helper'

describe "posts/edit.html.erb" do
  before(:each) do
    @post = Post.create!(:title => "title of the post", :content => "content of the post")
  end

  it "should contain title of the post" do
    render :file => '/posts/edit.html.erb'
    response.should have_selector("input", :type => "text", :name => "post[title]", :value => @post.title)
  end

  it "should contain content of the post" do
    render
    response.should contain(@post.content)
  end

  it "should not have missing translations" do
    render
    response.should_not contain("translation missing")
  end
end
