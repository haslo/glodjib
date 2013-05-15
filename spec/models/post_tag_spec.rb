require 'spec_helper'

describe PostTag do
  let(:new_valid_record) { PostTag.new(:tag_text => "tag") }

  it { should validate_presence_of :tag_text }
  it { should validate_uniqueness_of(:tag_text) }

  it { should have_and_belong_to_many :posts }

  it_behaves_like "a model that accepts text", :tag_text
end
