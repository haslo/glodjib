require 'spec_helper'

describe "posts/frontpage.html.erb" do
  before(:each) do
    @posts = [ Post.create!(:title => "title of the post 1", :content => "content of the post 1!!more!!new content after the split"),
               Post.create!(:title => "title of the post 2", :content => "content of the post 2!!more!!new content after the split") ]
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

  it "should contain contents of all posts" do
    render
    @posts.each do |post|
      response.should contain(post.content)
    end
  end

  it "should not have missing translations" do
    render
    response.should_not contain("translation missing")
  end
end
