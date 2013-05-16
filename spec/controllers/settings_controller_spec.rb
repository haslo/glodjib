require 'spec_helper'

describe SettingsController, :issue23 => true do
  describe "as a logged in user" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @user = User.create!(:email => "test@mail.com", :password => "password", :password_confirmation => "password")
      sign_in @user
    end

    describe "routing" do
      it "routes /admin/settings to #index with get" do
        settings_path.should == "/admin/settings"
        expect(:get => settings_path).to route_to(:controller => "settings", :action => "index")
      end

      it "routes /admin/settings to #index with post" do
        update_settings_path.should == "/admin/settings"
        expect(:post => update_settings_path).to route_to(:controller => "settings", :action => "index")
      end
    end

    describe "actions" do
      describe "GET 'index'" do
        get :index do
          should_render 'index'
        end
      end

      describe "POST 'index'" do
        describe "with empty values" do
          it "adds a flash error" do
            post 'index', :setting => {}
            flash[:error].should_not be_nil
          end
          end

          describe "with empty values, but valid password" do
            before(:each) do
              @params = {:admin_password => "12345678", :admin_password_confirmation => "12345678"}
            end

            it "adds a flash error" do
              post 'index', :setting => @params
              flash[:error].should_not be_nil
            end

            it "does not update the first user's password" do
              encrypted_password = User.first.encrypted_password
              post 'index', :setting => @params
              encrypted_password.should == User.first.encrypted_password
            end
          end

          describe "with valid values (no password)" do
            before(:each) do
              @params = {:flickr_user => 'user', :flickr_api_key => '1234', :flickr_shared_secret => '1324', :page_title => 'page title', :post_more_separator => '!!more!!'}
            end

            it "updates the settings with new parameters for api key, shared secret, page title" do
              post 'index', :setting => @params
              Setting.flickr_user.should == @params[:flickr_user]
              Setting.flickr_api_key.should == @params[:flickr_api_key]
              Setting.flickr_shared_secret.should == @params[:flickr_shared_secret]
              Setting.page_title.should == @params[:page_title]
            end
          end

          describe "with valid values including password" do
            before(:each) do
              @params = {:flickr_user => 'user', :flickr_api_key => '1234', :flickr_shared_secret => '1324', :page_title => 'page title', :post_more_separator => '!!more!!', :admin_password => "12345678", :admin_password_confirmation => "12345678"}
            end

            it "updates the settings with new parameters for api key, shared secret, page title" do
              post 'index', :setting => @params
              Setting.flickr_user.should == @params[:flickr_user]
              Setting.flickr_api_key.should == @params[:flickr_api_key]
              Setting.flickr_shared_secret.should == @params[:flickr_shared_secret]
              Setting.page_title.should == @params[:page_title]
            end

            it "does not update admin_password or admin_password_confirmation" do
              post 'index', :setting => @params
              Setting.admin_password.should be_nil
              Setting.admin_password_confirmation.should be_nil
            end

            it "updates the first user's password" do
              encrypted_password = User.first.encrypted_password
              post 'index', :setting => @params
              encrypted_password.should_not == User.first.encrypted_password
            end
          end

          describe "with valid values but invalid password" do
            before(:each) do
              @params = {:flickr_user => 'user', :flickr_api_key => '1234', :flickr_shared_secret => '1324', :page_title => 'page title', :post_more_separator => '!!more!!', :admin_password => "12345678", :admin_password_confirmation => "87654321"}
            end

            it "updates the settings with new parameters for api key, shared secret, page title" do
              post 'index', :setting => @params
              Setting.flickr_user.should == @params[:flickr_user]
              Setting.flickr_api_key.should == @params[:flickr_api_key]
              Setting.flickr_shared_secret.should == @params[:flickr_shared_secret]
              Setting.page_title.should == @params[:page_title]
            end

            it "does not update admin_password or admin_password_confirmation" do
              post 'index', :setting => @params
              Setting.admin_password.should be_nil
              Setting.admin_password_confirmation.should be_nil
            end

            it "does not update the first user's password" do
              encrypted_password = User.first.encrypted_password
              post 'index', :setting => @params
              encrypted_password.should == User.first.encrypted_password
            end

            it "shows a flash error" do
              post 'index', :setting => @params
              flash[:error].should_not be_nil
            end
          end
      end
    end
  end
end
