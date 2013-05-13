require 'spec_helper'

describe FlickrAPI do
  let(:new_valid_record) { FlickrAPI.new }

  it "is not persisted" do
    new_valid_record.should_not be_persisted
  end

  shared_examples_for "automatically fills default values" do |property|
    it "automatically fills a default value for #{property}" do
      new_valid_record.send(property.to_sym).should_not be_blank
    end
  end

  it_behaves_like "automatically fills default values", :api_key
  it_behaves_like "automatically fills default values", :shared_secret
  it_behaves_like "automatically fills default values", :user_id

  shared_examples_for "takes constructor values" do |property|
    it "returns constructor value for #{property}" do
      record = FlickrAPI.new(property.to_sym => "test value")
      record.send(property.to_sym).should == "test value"
    end
  end

  it_behaves_like "takes constructor values", :api_key
  it_behaves_like "takes constructor values", :shared_secret
  it_behaves_like "takes constructor values", :user_id

  describe "#get_images_with_tags" do
    before(:each) do
      @flickr_api = new_valid_record
    end

    it "fetches all images with a tag from cache"
    it "refreshes the cache if it is empty"
    it "refreshes the cache if it has timed out"
  end

  describe "#fill_cache_for_tags" do
    before(:each) do
      @flickr_api = new_valid_record
    end

    it "connects to FlickRAW"
    it "fills the images it obtains from Flickr into the FlickrImage model"
    it "fills all the tags it obtains into the FlickrTag model"
    it "assigns all the images it obtains to the current user in a FlickrUser model"
  end
end
