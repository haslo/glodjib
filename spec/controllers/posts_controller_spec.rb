require 'spec_helper'

describe PostsController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    describe "with invalid id" do
      it "raises RecordNotFound" do
        expect { get 'show', :id => -1 }.to raise_error ActiveRecord::RecordNotFound
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
