require 'spec_helper'

describe PostCommentsController, :issue4 => true do
  describe "routing" do
    it "routes /:post_id to #create with POST" do
      post_comment_path(:post_id => "test").should == "/test"
      expect(:post => post_comment_path(:post_id => "test")).to route_to(:controller => "post_comments", :action => "create", :post_id => "test")
    end
  end

  describe "actions" do
    describe "POST 'create'" do
      describe "called with no valid post_id value" do
        it "redirects to the homepage" do
          post 'create', { :post_id => '-1', :post_comment => { :post_id => nil, :name => nil, :comment => nil }}
          response.should redirect_to root_path
        end
      end

      describe "called with post id" do
        before(:each) do
          @post = Post.create(:title => "title", :content => "content")
        end

        describe "with nil values" do
          it "returns http success" do
            post 'create', { :post_id => @post.id, :post_comment => { :post_id => @post.id, :name => nil, :comment => nil }}
            response.should be_success
          end

          it "does not create a comment" do
            expect { post('create', { :post_id => @post.id, :post_comment => { :post_id => @post.id, :name => nil, :comment => nil }}) }.to_not change(PostComment, :count)
          end
        end

        describe "with valid comment values" do
          it "redirects to the post" do
            post 'create', { :post_id => @post.id, :post_comment => { :post_id => @post.id, :name => "name", :comment => "comment" }}
            response.should redirect_to post_path(:id => @post.shorthand)
          end

          it "creates one post" do
            expect { post('create', { :post_id => @post.id, :post_comment => { :post_id => @post.id, :name => "name", :comment => "comment" }}) }.to change(PostComment, :count).from(0).to(1)
          end
        end
      end

      describe "called with post shorthand" do
        before(:each) do
          @post = Post.create(:title => "title", :content => "content")
        end

        describe "with nil values" do
          it "returns http success" do
            post 'create', { :post_id => @post.shorthand, :post_comment => { :post_id => @post.id, :name => nil, :comment => nil }}
            response.should be_success
          end

          it "does not create a comment" do
            expect { post('create', { :post_id => @post.shorthand, :post_comment => { :post_id => @post.id, :name => nil, :comment => nil }}) }.to_not change(Post, :count)
          end
        end

        describe "with valid comment values" do
          it "redirects to the post" do
            post 'create', { :post_id => @post.shorthand, :post_comment => { :post_id => @post.id, :name => "name", :comment => "comment" }}
            response.should redirect_to post_path(:id => @post.shorthand)
          end

          it "creates one post" do
            expect { post('create', { :post_id => @post.shorthand, :post_comment => { :post_id => @post.id, :name => "name", :comment => "comment" }}) }.to change(PostComment, :count).from(0).to(1)
          end
        end
      end
    end
  end
end
