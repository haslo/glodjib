require 'spec_helper'

describe FlickrImagesController do
  extend ControllerMacros

  describe "routing" do
    it "routes /portfolio to #portfolio" do
      portfolio_path.should == "/portfolio"
      expect(:get => portfolio_path).to route_to(:controller => "flickr_images", :action => "portfolio")
    end

    it "routes /admin/reset_caches to #reset_caches" do
      reset_caches_path.should == "/admin/reset_caches"
      expect(:delete => reset_caches_path).to route_to(:controller => "flickr_images", :action => "reset_caches")
    end
  end

  describe "actions" do
    describe "GET 'portfolio'", :flickr_api => true do
      get :portfolio do
        should_render 'portfolio'
      end

      it "calls the FlickrAPI" do
        flickr_api = FlickrAPI.new
        FlickrAPI.should_receive(:new).and_return(flickr_api)
        get 'portfolio'
      end
    end

    describe "DELETE 'reset_caches'" do
      it "should delete all FlickrCache model instances" do
        FlickrCache.should_receive(:destroy_all)
        delete 'reset_caches'
      end

      it "should redirect to the portfolio" do
        delete 'reset_caches'
        response.should redirect_to(portfolio_path)
      end
    end
  end
end
