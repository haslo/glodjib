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

  describe "api calls" do
    before(:each) do
      @flickr_api = new_valid_record
    end

    describe "#get_images_with_tags" do
      it "fetches all images with a tag from cache"
      it "refreshes the cache if it is empty"
      it "refreshes the cache if it has timed out"
    end

    describe "#fill_cache_for_tags" do
      it "connects to FlickRAW"
      it "fills the images it obtains from Flickr into the FlickrImage model"
      it "fills all the tags it obtains into the FlickrTag model"
      it "assigns all the images it obtains to the current user in a FlickrUser model"
    end

    describe "#find_or_create_cache" do
      it "creates a user if there is none" do
        expect { @flickr_api.find_or_create_cache("username", "tag") }.to change(FlickrUser, :count).from(0).to(1)
      end

      it "creates a tag if there is none" do
        expect { @flickr_api.find_or_create_cache("username", "tag") }.to change(FlickrTag, :count).from(0).to(1)
      end

      it "creates a cache if there is none" do
        expect { @flickr_api.find_or_create_cache("username", "tag") }.to change(FlickrCache, :count).from(0).to(1)
      end

      it "returns an instance of FlickrCache" do
        @flickr_api.find_or_create_cache("username", "tag").should be_an_instance_of FlickrCache
      end
    end
  end
end
