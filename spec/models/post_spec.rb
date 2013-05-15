require 'spec_helper'

describe Post do
  let(:new_valid_record) { Post.new(:title => "title", :content => "content") }

  it { should validate_presence_of :title }
  it { should validate_presence_of :shorthand }
  it { should validate_presence_of :content }

  it { should validate_uniqueness_of(:shorthand) }

  it { should have_and_belong_to_many :post_tags }

  it "accepts post_tags into its post_tags list" do
    post = new_valid_record
    post_tag = PostTag.new(:tag_text => "tag")
    post.post_tags << post_tag
    post.save
    post_tag.save
    post.post_tags.should have(1).items
  end

  describe "the shorthand has to start with an alphabetical character" do
    it "does not allow a numerical character up front" do
      record = new_valid_record
      record.shorthand = "123"
      record.valid?
      record.errors[:shorthand].should include("shorthand must start with a character")
    end
  end

  it_behaves_like "a model that accepts text", :title
  it_behaves_like "a model that accepts text", :shorthand
  it_behaves_like "a model that accepts text", :content

  it_behaves_like "a model that accepts html with links and formatting", :content

  it "sanitizes content before returning it" do
    record = new_valid_record
    new_content = "<script type=\"text/javascript\">alert(\"Hello World!\");</script><strong>test</strong>"
    record.content = new_content
    record.content.should == sanitize(new_content)
  end

  it "marks returned content as html_safe" do
    record = new_valid_record
    record.content.should be_html_safe
  end

  describe "automatically assigns an URL-compatible value to shorthand when the title is set" do
    describe "when generating shorthand from title" do
      it "assigns a lowercase title without spaces or special characters directly to the shorthand" do
        record = new_valid_record
        record.title = "testing123"
        record.shorthand.should == "testing123"
      end

      it "makes everything lowercase" do
        record = new_valid_record
        record.title = "TesTinG"
        record.shorthand.should == "testing"
      end

      it "strips spaces and puts _ there" do
        record = new_valid_record
        record.title = "testing title"
        record.shorthand.should == "testing_title"
      end

      it "removes all non-alphanumerical characters" do
        record = new_valid_record
        record.title = "testing123%&"
        record.shorthand.should == "testing123"
      end
    end

    describe "when accepting explicit shorthand" do
      it "makes everything lowercase" do
        record = new_valid_record
        record.shorthand = "TesTinG"
        record.shorthand.should == "testing"
      end

      it "strips spaces and puts _ there" do
        record = new_valid_record
        record.shorthand = "testing title"
        record.shorthand.should == "testing_title"
      end

      it "removes all non-alphanumerical characters" do
        record = new_valid_record
        record.shorthand = "testing123%&"
        record.shorthand.should == "testing123"
      end
    end

    it "overwrites automatically saved shorthands when the title is updated" do
      record = new_valid_record
      record.title = "Initial Testing"
      record.title = "Some More Testing"
      record.shorthand.should == "some_more_testing"
    end

    it "doesn't overwrite explicitly saved shorthands when the title is updated" do
      record = new_valid_record
      record.shorthand = "testing123"
      record.title = "Some More Testing"
      record.shorthand.should == "testing123"
    end

    it "resets the shorthand to auto-generated when it is manually set to a blank value" do
      record = new_valid_record
      record.shorthand = "testing123"
      record.title = "Some More Testing"
      record.shorthand = nil
      record.shorthand.should == "some_more_testing"
    end
  end
end
