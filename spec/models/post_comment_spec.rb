require 'spec_helper'

describe PostComment, :issue4 => true do
  let(:new_valid_record) { PostComment.new(:name => "name", :comment => "comment") }

  it { should validate_presence_of :name }
  it { should validate_presence_of :comment }

  it { should belong_to :post }

  it_behaves_like "a model that accepts text", :name
  it_behaves_like "a model that accepts text", :url
  it_behaves_like "a model that accepts text", :email
  it_behaves_like "a model that accepts text", :comment

  pending "more specs"
end
