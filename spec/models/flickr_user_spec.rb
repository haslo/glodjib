require 'spec_helper'

describe FlickrUser do
  let(:new_valid_record) { FlickrUser.new(:username => "username") }

  it { should have_many(:flickr_images) }
  it { should have_many(:flickr_caches) }

  it { should validate_presence_of :username }

  it_behaves_like "a model that accepts text", :username
end
