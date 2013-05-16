require 'spec_helper'

describe "flickr_images/portfolio.html.erb" do
  before(:each) do
    @flickr_images = []
    1.upto(10).each do |index|
      @flickr_images << FlickrImage.new(:image_title => "image title #{index}", :full_flickr_url => "url #{index}", :flickr_thumbnail_url => "thumbnail #{index}")
    end
    view.stub(:user_signed_in?) { true }
  end

  it "should contain titles of all images" do
    render
    @flickr_images.each do |flickr_image|
      response.should contain(flickr_image.image_title)
    end
  end

  it "should contain URLs of all images" do
    render
    @flickr_images.each do |flickr_image|
      response.should have_selector("a", :href => flickr_image.full_flickr_url)
    end
  end

  it "should contain all the thumbnails themselves" do
    render
    @flickr_images.each do |flickr_image|
      response.should have_selector("img", :src => flickr_image.flickr_thumbnail_url)
    end
  end

  it "should not have missing translations" do
    render
    response.should_not contain("translation missing")
  end
end
