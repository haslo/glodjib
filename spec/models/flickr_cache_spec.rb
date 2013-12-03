require 'spec_helper'

describe FlickrCache do
  let(:new_valid_record) { FlickrCache.new(:flickr_user => FlickrUser.new(:username => 'username'), :flickr_tag => FlickrTag.new(:tag_name => 'tag')) }

  it { should belong_to(:flickr_user) }
  it { should belong_to(:flickr_tag) }

  it { should validate_presence_of :flickr_user }
  it { should validate_presence_of :flickr_tag }
end
