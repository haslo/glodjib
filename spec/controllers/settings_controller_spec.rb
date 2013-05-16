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
        settings_path.should == "/admin/settings"
        expect(:put => settings_path).to route_to(:controller => "settings", :action => "update_all")
      end
    end

    describe "actions" do
      describe "GET 'index'" do
        get :index do
          should_render 'index'
        end
      end
    end
  end
end
