require 'spec_helper'

describe "flickr_images/portfolio.html.erb" do
  before(:each) do
    @flickr_images = [ FlickrImage.new(:image_title => "image title 1"), FlickrImage.new(:image_title => "image title 2") ]
    @flickr_images.each do |flickr_image|
      flickr_image.created_at = Time.now
    end
  end

  it "should contain titles of all images" do
    render
    @flickr_images.each do |flickr_image|
      response.should contain(flickr_image.image_title)
    end
  end
end
