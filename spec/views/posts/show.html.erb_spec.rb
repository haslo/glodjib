require 'spec_helper'

describe "posts/show.html.erb" do
  before(:each) do
    @post = Post.create!(:title => "title of the post 1", :content => "<p>content of the post 1!!more!!<strong>new</strong> 1 content after the split</p>")
  end

  it "should not contain title of the post, because the layout does contain it" do
    render
    response.should_not contain(@post.title)
  end

  it "should contain date of the post in short format" do
    render
    response.should contain(I18n.l(@post.created_at, :format => :short))
  end

  it "should contain content of the post, with !!more!! replaced with </p><p>" do
    render
    response.should contain(Nokogiri::HTML::DocumentFragment.parse(@post.content.gsub('!!more!!', '</p><p>')).text)
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
