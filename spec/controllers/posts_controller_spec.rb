require 'spec_helper'
require 'pp'

describe PostsController do
  extend ControllerMacros

  describe "routing" do
    it "routes / to #frontpage" do
      root_path.should == "/"
      expect(:get => root_path).to route_to(:controller => "posts", :action => "frontpage")
    end

    it "routes /:id to #show" do
      post_path(:id => 'test').should == "/test"
      expect(:get => post_path(:id => 'test')).to route_to(:controller => "posts", :action => "show", :id => "test")
    end

    it "routes /admin/posts to #index" do
      posts_path.should == "/admin/posts"
      expect(:get => posts_path).to route_to(:controller => "posts", :action => "index")
    end

    it "routes /admin/posts/new to #new" do
      new_post_path.should == "/admin/posts/new"
      expect(:get => new_post_path).to route_to(:controller => "posts", :action => "new")
    end

    it "routes /admin/posts/:id to #destroy" do
      destroy_post_path(:id => "test").should == "/admin/posts/test"
      expect(:delete => destroy_post_path(:id => "test")).to route_to(:controller => "posts", :action => "destroy", :id => "test")
    end
  end

  describe "actions" do
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
      describe "with nil values" do
        it "returns http success" do
          post 'create', { :post => { :title => nil, :content => nil }}
          response.should be_success
        end

        it "does not create a post" do
          expect { post('create', { :post => { :title => nil, :content => nil } }) }.to_not change(Post, :count)
        end
      end

      describe "with valid post values" do
        it "redirects to the posts list" do
          post 'create', { :post => { :title => "title", :content => "content" }}
          response.should redirect_to posts_path
        end

        it "creates one post" do
          expect { post('create', { :post => { :title => "title", :content => "content" } }) }.to change(Post, :count).from(0).to(1)
        end
      end
    end
  end
end
