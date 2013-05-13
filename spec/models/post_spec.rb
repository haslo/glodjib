require 'spec_helper'

describe Post do
  let(:new_valid_record) { Post.new }

  it { should validate_presence_of :title }
  it { should validate_presence_of :shorthand }
  it { should validate_presence_of :content }

  it_behaves_like "a model that accepts text", :title
  it_behaves_like "a model that accepts text", :shorthand
  it_behaves_like "a model that accepts text", :content

  it_behaves_like "a model that accepts html with links and formatting", :content

  it { should validate_uniqueness_of(:shorthand) }

  describe "automatically assigns an URL-compatible value to shorthand when the title is set" do
    it "makes everything lowercase" do
      record = new_valid_record
      record.shorthand = nil
      record.title = "TesTinG"
      record.shorthand.should == "testing"
    end

    it "strips spaces and puts _ there" do
      record = new_valid_record
      record.shorthand = nil
      record.title = "testing title"
      record.shorthand.should == "testing_title"
    end

    it "removes all non-alphanumerical characters" do
      record = new_valid_record
      record.shorthand = nil
      record.title = "testing123%&"
      record.shorthand.should == "testing123"
    end
  end
end
