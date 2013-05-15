require 'spec_helper'
require 'pp'

describe PostsController, :controller => true do
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

    it "routes /admin/posts/:id/edit to #edit" do
      edit_post_path(:id => "test").should == "/admin/posts/test/edit"
      expect(:get => edit_post_path(:id => "test")).to route_to(:controller => "posts", :action => "edit", :id => "test")
      expect(:put => edit_post_path(:id => "test")).to route_to(:controller => "posts", :action => "edit", :id => "test")
    end

    it "routes /admin/posts/:id to #destroy" do
      destroy_post_path(:id => "test").should == "/admin/posts/test"
      expect(:delete => destroy_post_path(:id => "test")).to route_to(:controller => "posts", :action => "destroy", :id => "test")
    end
  end

  describe "actions" do
    describe "GET 'frontpage'" do
      get :frontpage do
        should_render 'frontpage'
      end
    end

    describe "GET 'index'" do
      get :index do
        should_render 'frontpage'
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

        it "adds a flash error" do
          get 'show', :id => -1
          flash[:error].should_not be_nil
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
      get :new do
        should_render 'new'
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

    describe "GET 'edit'" do
      describe "with invalid id" do
        it "does not return http success" do
          get 'edit', :id => -1
          response.should_not be_success
        end

        it "redirects to the posts path" do
          get 'edit', :id => -1
          response.should redirect_to posts_path
        end

        it "adds a flash error" do
          get 'edit', :id => -1
          flash[:error].should_not be_nil
        end
      end

      describe "with valid post" do
        before(:each) do
          @post = Post.new(:title => "title", :shorthand => "shorthand", :content => "content")
          @post.save!
        end

        it "returns http success" do
          get 'edit', :id => @post.id
          response.should be_success
        end
      end
    end


    describe "PUT 'edit'" do
      describe "with invalid id" do
        it "does not return http success" do
          put 'edit', :id => -1
          response.should_not be_success
        end

        it "redirects to the posts path" do
          put 'edit', :id => -1
          response.should redirect_to posts_path
        end

        it "adds a flash error" do
          put 'edit', :id => -1
          flash[:error].should_not be_nil
        end
      end

      describe "with valid post" do
        before(:each) do
          @post = Post.new(:title => "title", :shorthand => "shorthand", :content => "content")
          @post.save!
        end

        describe "with invalid updates" do
          it "returns http success" do
            put 'edit', :id => @post.id, :post => {:title => "", :content => "", :shorthand => "invalid % shorthand"}
            response.should be_success
          end

          it "updates the displayed post with the edited values" do
            put 'edit', :id => @post.id, :post => {:title => "new title", :content => "", :shorthand => "invalid % shorthand"}
            assigns[:post].title.should == "new title"
          end

          it "does not create a post" do
            expect { put('edit', { :id => @post.id, :post => {:title => "", :content => "", :shorthand => "invalid % shorthand"} }) }.to_not change(Post, :count)
          end
        end

        describe "with valid updates" do
          it "redirects to the posts path" do
            put 'edit', :id => @post.id, :post => {:title => "new title", :content => "new content", :shorthand => "new_shorthand"}
            response.should redirect_to posts_path
          end

          it "updates the post with new parameters for title, content, shorthand" do
            put 'edit', :id => @post.id, :post => {:title => "new title", :content => "new content", :shorthand => "new_shorthand"}
            new_post = Post.find(@post.id)
            new_post.title.should == "new title"
            new_post.content.should == "new content"
            new_post.shorthand.should == "new_shorthand"
          end

          it "does not create a post" do
            expect { put('edit', { :id => @post.id, :post => {:title => "new title", :content => "new content", :shorthand => "new_shorthand"} }) }.to_not change(Post, :count)
          end
        end
      end
    end

    describe "DELETE 'destroy'", :current => true do
      describe "with invalid id" do
        it "does not return http success" do
          delete 'destroy', :id => -1
          response.should_not be_success
        end

        it "redirects to the posts path" do
          delete 'destroy', :id => -1
          response.should redirect_to posts_path
        end

        it "adds a flash error" do
          delete 'destroy', :id => -1
          flash[:error].should_not be_nil
        end
      end

      describe "with valid id" do
        before(:each) do
          @post = Post.new(:title => "title", :shorthand => "shorthand", :content => "content")
          @post.save!
        end

        it "redirects to the posts path" do
          delete 'destroy', :id => @post.id
          response.should redirect_to posts_path
        end

        it "destroys the post" do
          expect { delete('destroy', { :id => @post.id }) }.to change(Post, :count).from(1).to(0)
        end
      end
    end
  end
end
