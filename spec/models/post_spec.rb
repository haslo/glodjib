require 'spec_helper'

describe Post do
  let(:new_valid_record) { Post.new }

  it_behaves_like "a model that validates presence of", :title
  it_behaves_like "a model that validates presence of", :content
  it_behaves_like "a model that validates presence of", :shorthand
end
