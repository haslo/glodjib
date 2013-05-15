require 'spec_helper'

describe PostTagController do
  describe "routing" do
    it "routes /tag/:id to #show" do
      post_tag_path(:id => "test").should == "/tag/test"
      expect(:get => post_tag_path(:id => "test")).to route_to(:controller => "post_tag", :action => "show", :id => "test")
    end
  end

  describe "actions" do
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

      describe "with valid post_tag" do
        before(:each) do
          @post_tag = PostTag.create!(:tag_text => "tag")
        end

        describe "with no posts assigned" do
          it "does not return http success" do
            get 'show', :id => @post_tag.id
            response.should_not be_success
          end

          it "redirects to the root path" do
            get 'show', :id => @post_tag.id
            response.should redirect_to root_path
          end

          it "adds a flash error" do
            get 'show', :id => @post_tag.id
            flash[:error].should_not be_nil
          end
        end

        describe "with two posts assigned" do
          before(:each) do
            @post_tag.posts << Post.create!(:title => "title 1", :content => "content 1")
            @post_tag.posts << Post.create!(:title => "title 2", :content => "content 2")
          end

          describe "called with id" do
            it "returns http success" do
              get 'show', :id => @post_tag.id
              response.should be_success
            end

            it "renders the show template" do
              get 'show', :id => @post_tag.id
              response.should render_template('show')
            end

            it "finds the proper post_tag" do
              get 'show', :id => @post_tag.id
              assigns[:post_tag].should == @post_tag
            end

            it "assigns posts as well" do
              get 'show', :id => @post_tag.id
              assigns[:posts].should == @post_tag.posts
            end
          end

          describe "called with tag_text" do
            it "returns http success" do
              get 'show', :id => @post_tag.tag_text
              response.should be_success
            end

            it "renders the show template" do
              get 'show', :id => @post_tag.id
              response.should render_template('show')
            end

            it "finds the proper post_tag" do
              get 'show', :id => @post_tag.tag_text
              assigns[:post_tag].should == @post_tag
            end

            it "assigns posts as well" do
              get 'show', :id => @post_tag.id
              assigns[:posts].should == @post_tag.posts
            end
          end
        end
      end
    end
  end
end
