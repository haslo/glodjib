require 'spec_helper'

describe PostTag do
  let(:new_valid_record) { PostTag.new(:tag_text => "tag") }

  it { should validate_presence_of :tag_text }
  it { should validate_uniqueness_of(:tag_text) }

  it { should have_and_belong_to_many :posts }

  it_behaves_like "a model that accepts text", :tag_text

  it "accepts posts into its posts list" do
    post_tag = new_valid_record
    post = Post.create!(:title => "title", :content => "content")
    post_tag.posts << post
    post_tag.posts.should have(1).items
  end

  describe "tag_text parsing" do
    it "downcases assigns to its post_tag member" do
      record = new_valid_record
      record.tag_text = "TaGtExT"
      record.tag_text.should == "tagtext"
    end

    it "strips spaces and puts _ there" do
      record = new_valid_record
      record.tag_text = "testing tag text"
      record.tag_text.should == "testing_tag_text"
    end

    it "removes all non-alphanumerical characters" do
      record = new_valid_record
      record.tag_text = "testing123%&"
      record.tag_text.should == "testing123"
    end

    it "strips starting and ending whitespace" do
      record = new_valid_record
      record.tag_text = "   testing   "
      record.tag_text.should == "testing"
    end
  end
end
