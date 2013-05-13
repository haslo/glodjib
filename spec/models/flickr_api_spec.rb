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
end
