require 'spec_helper'

describe "posts/frontpage.html.erb" do
  before(:each) do
    @posts = [ Post.new(:title => "title of the post 1", :content => "content of the post 1"),
               Post.new(:title => "title of the post 2", :content => "content of the post 2") ]
    @posts.each do |post|
      post.created_at = Time.now
    end
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
end
