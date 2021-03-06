require 'spec_helper'

describe FlickrTag do
  let(:new_valid_record) { FlickrTag.new(:tag_name => 'tagname') }

  it { should have_and_belong_to_many(:flickr_images) }
  it { should have_many(:flickr_caches) }

  it { should validate_presence_of :tag_name }

  it_behaves_like 'a model that accepts text', :tag_name
end
