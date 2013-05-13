require 'spec_helper'
require 'pp'

describe PostsController do
  describe "GET 'frontpage'" do
    it "returns http success" do
      get 'frontpage'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    describe "with invalid id" do
      it "does not return http success" do
        get 'show', :id => -1
        response.should_not be_success
      end

      it "redirects to the root path" do
        get 'show', :id => -1
        response.should redirect_to root_path
      end
    end

    describe "with valid post" do
      before(:each) do
        @post = Post.new(:title => "title", :shorthand => "shorthand", :content => "content")
        @post.save!
      end

      describe "called with id" do
        it "returns http success" do
          get 'show', :id => @post.id
          response.should be_success
        end
      end

      describe "called with shorthand" do
        it "returns http success" do
          get 'show', :id => @post.shorthand
          response.should be_success
        end
      end
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post 'create'
      response.should be_success
    end
  end
end
