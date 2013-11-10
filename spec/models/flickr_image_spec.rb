require 'spec_helper'

describe FlickrImage do
  let(:new_valid_record) { FlickrImage.new }

  it { should belong_to(:flickr_user) }
  it { should have_and_belong_to_many(:flickr_tags) }

  it { should validate_presence_of :flickr_id }
  it { should validate_presence_of :image_title }

  it_behaves_like 'a model that accepts text', :flickr_id
  it_behaves_like 'a model that accepts text', :image_title
  it_behaves_like 'a model that accepts text', :image_description
  it_behaves_like 'a model that accepts text', :aperture
  it_behaves_like 'a model that accepts text', :shutter
  it_behaves_like 'a model that accepts text', :iso
  it_behaves_like 'a model that accepts text', :focal_length
  it_behaves_like 'a model that accepts text', :camera
  it_behaves_like 'a model that accepts text', :full_flickr_url
  it_behaves_like 'a model that accepts text', :flickr_thumbnail_url
end
