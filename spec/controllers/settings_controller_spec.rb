require 'spec_helper'

describe SettingsController, :blub => true do
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

      it "routes /admin/settings to #update_all with put" do
        update_settings_path.should == "/admin/settings"
        expect(:put => update_settings_path).to route_to(:controller => "settings", :action => "update_all")
      end
    end

    describe "actions" do
      describe "GET 'index'" do
        get :index do
          should_render 'index'
        end
      end

      describe "PUT 'update_all'" do
          describe "with empty values" do
            it "does not return http success" do
              put 'update_all', :setting => {}
              response.should_not be_success
            end

            it "redirects to the settings path" do
              put 'update_all', :setting => {}
              response.should redirect_to settings_path
            end

            it "adds a flash error" do
              put 'update_all', :setting => {}
              flash[:error].should_not be_nil
            end
          end

          describe "with valid values (no password)" do
            before(:each) do
              @params = {:flickr_api_key => '1234', :flickr_shared_secret => '1324', :page_title => 'page title', :post_more_separator => '!!more!!'}
            end

            it "redirects to the settings path" do
              put 'update_all', :setting => @params
              response.should redirect_to settings_path
            end

            it "updates the settings with new parameters for api key, shared secret, page title" do
              put 'update_all', :setting => @params
              Setting.get(:flickr_api_key).should == @params[:flickr_api_key]
              Setting.get(:flickr_shared_secret).should == @params[:flickr_shared_secret]
              Setting.get(:page_title).should == @params[:page_title]
            end
          end
      end
    end
  end
end
