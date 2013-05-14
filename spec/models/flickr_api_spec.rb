require 'spec_helper'
require 'flickraw'

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
  it_behaves_like "automatically fills default values", :flickr_user

  shared_examples_for "takes constructor values" do |property|
    it "returns constructor value for #{property}" do
      record = FlickrAPI.new(property.to_sym => "test value")
      record.send(property.to_sym).should == "test value"
    end
  end

  it_behaves_like "takes constructor values", :api_key
  it_behaves_like "takes constructor values", :shared_secret
  it_behaves_like "takes constructor values", :flickr_user

  describe "the api" do
    it "creates a FlickrUser for the default Flickr username" do
      expect { FlickrAPI.new }.to change(FlickrUser, :count).from(0).to(1)
    end
  end

  describe "api calls" do
    before(:each) do
      @flickr_api = new_valid_record
    end

    describe "#get_images_from_remote" do
      before(:each) do
        FlickRaw.api_key = @flickr_api.api_key
        FlickRaw.shared_secret = @flickr_api.shared_secret
      end

      it "is being tested with a Flickr search for the tag 'portfolio' that actually returns images" do
        flickr.photos.search(:user_id => @flickr_api.flickr_user.username, :tags => "portfolio").size.should > 0
      end

      it "fetches all images with a tag and the current user from Flickr" do
        image_count = flickr.photos.search(:user_id => @flickr_api.flickr_user.username, :tags => "portfolio").size
        @flickr_api.get_images_from_remote(@flickr_api.find_or_create_cache("portfolio")).count.should == image_count
      end
    end

    describe "#update_cache" do
      before(:each) do
        FlickRaw.api_key = @flickr_api.api_key
        FlickRaw.shared_secret = @flickr_api.shared_secret
      end

      it "creates a cache if there is none" do
        expect { @flickr_api.update_cache(@flickr_api.find_or_create_cache("portfolio")) }.to change(FlickrCache, :count).from(0).to(1)
      end

      it "is being tested with a Flickr search for the tag 'portfolio' that actually returns images" do
        flickr.photos.search(:user_id => @flickr_api.flickr_user.username, :tags => "portfolio").size.should > 0
      end

      it "fills the images it obtains from Flickr into the FlickrImage model" do
        image_count = flickr.photos.search(:user_id => @flickr_api.flickr_user.username, :tags => "portfolio").size
        expect { @flickr_api.update_cache(@flickr_api.find_or_create_cache("portfolio")) }.to change(FlickrImage, :count).from(0).to(image_count)
      end

      it "returns true if there was a cache update" do
        @flickr_api.update_cache(@flickr_api.find_or_create_cache("portfolio")).should == true
      end

      it "returns false if there was no cache update" do
        flickr_cache = @flickr_api.find_or_create_cache("portfolio")
        flickr_cache.refresh_timeout
        @flickr_api.update_cache(flickr_cache).should == false
      end

      it "resets the images currently associated with the tag it refreshes" do
        flickr_tag = FlickrTag.new(:tag_name => "portfolio")
        0.upto(20).each do |index|
          image = FlickrImage.new(:flickr_id => "image#{index}", :image_title => "image #{index}", :flickr_user => @flickr_api.flickr_user)
          flickr_tag.flickr_images << image
          image.save
        end
        flickr_tag.save
        image_count = flickr.photos.search(:user_id => @flickr_api.flickr_user.username, :tags => "portfolio").size
        expect { @flickr_api.update_cache(@flickr_api.find_or_create_cache("portfolio")) }.to change(flickr_tag.flickr_images, :count).from(21).to(image_count)
      end

      it "fills all the tags it obtains into the FlickrTag model" do
        @flickr_api.update_cache(@flickr_api.find_or_create_cache("portfolio"))
        FlickrTag.count.should > 0
      end

      it "assigns all the images it obtains to the correct user in a FlickrUser model" do
        image_count = flickr.photos.search(:user_id => @flickr_api.flickr_user.username, :tags => "portfolio").size
        @flickr_api.update_cache(@flickr_api.find_or_create_cache("portfolio"))
        @flickr_api.flickr_user.flickr_images.count.should == image_count
      end

      shared_examples_for "a proper Flickr storage" do |property|
        it "stores #{property}" do
          @flickr_api.update_cache(@flickr_api.find_or_create_cache("portfolio"))
          FlickrImage.first.send(property.to_sym).should_not be_nil
        end
      end

      it_behaves_like "a proper Flickr storage", :image_description
      it_behaves_like "a proper Flickr storage", :aperture
      it_behaves_like "a proper Flickr storage", :shutter
      it_behaves_like "a proper Flickr storage", :iso
      it_behaves_like "a proper Flickr storage", :focal_length
    end

    describe "#find_or_create_cache" do
      it "uses the default user if it gets only a tag parameter" do
        expect { @flickr_api.find_or_create_cache("tag") }.to_not change(FlickrUser, :count)
      end

      it "creates a user if there is none" do
        expect { @flickr_api.find_or_create_cache("tag", "username") }.to change(FlickrUser, :count).from(1).to(2)
      end

      it "creates a tag if there is none" do
        expect { @flickr_api.find_or_create_cache("tag", "username") }.to change(FlickrTag, :count).from(0).to(1)
      end

      it "creates a cache if there is none" do
        expect { @flickr_api.find_or_create_cache("tag", "username") }.to change(FlickrCache, :count).from(0).to(1)
      end

      it "does not create a cache if there is one" do
        @flickr_api.find_or_create_cache("portfolio")
        expect { @flickr_api.find_or_create_cache("portfolio") }.not_to change(FlickrCache, :count)
      end

      it "returns an instance of FlickrCache" do
        @flickr_api.find_or_create_cache("tag", "username").should be_an_instance_of FlickrCache
      end
    end
  end
end
