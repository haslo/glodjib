require 'spec_helper'

describe PostComment, :issue4 => true do
  let(:new_valid_record) { PostComment.new(:post_id => '-1', :name => 'name', :comment => 'comment') }

  it { should validate_presence_of :name }
  it { should validate_presence_of :comment }
  it { should validate_presence_of :post_id }

  it 'validates uniqueness of a comment with the correct custom message' do
    post_comment = new_valid_record
    post_comment.save
    new_post_comment = PostComment.new(:name => post_comment.name, :comment => post_comment.comment)
    new_post_comment.should_not be_valid
    new_post_comment.errors[:comment].should include I18n.t('notices.post_comment.duplicate')
  end

  it { should belong_to :post }

  it_behaves_like 'a model that accepts text', :name
  it_behaves_like 'a model that accepts text', :url
  it_behaves_like 'a model that accepts text', :email
  it_behaves_like 'a model that accepts text', :comment

  %w(name email url).each do |field|
    it "strips the #{field} of all html" do
      record = new_valid_record
      record.send("#{field}=", "<a href='blabla'>blabla</a>")
      record.send(field).should == 'blabla'
    end
  end

  it 'sanitizes the comment before returning it' do
    record = new_valid_record
    new_content = "<script type='text/javascript'>alert('Hello World!');</script><strong>test</strong>"
    record.comment = new_content
    record.comment.should == sanitize(new_content)
  end

  it 'marks returned content as html_safe' do
    record = new_valid_record
    record.comment.should be_html_safe
  end
end
