require 'spec_helper'

describe PostTag do
  let(:new_valid_record) { PostTag.new(:tag_text => "tag") }

  it { should validate_presence_of :tag_text }
  it { should validate_uniqueness_of(:tag_text) }

  it { should have_and_belong_to_many :posts }

  it_behaves_like "a model that accepts text", :tag_text

  it "accepts posts into its posts list" do
    post_tag = new_valid_record
    post = Post.new(:title => "title", :content => "content")
    post_tag.posts << post
    post.save
    post_tag.save
    post_tag.posts.should have(1).items
  end
end
