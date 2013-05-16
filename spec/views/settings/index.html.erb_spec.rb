require 'spec_helper'

describe "settings/index.html.erb", :issue23 => true do
  before(:each) do
    {:flickr_user => 'user', :flickr_api_key => '1234', :flickr_shared_secret => '5678', :page_title => 'page title', :post_more_separator => '!!more!!'}.each do |key, value|
      Setting.put(key, value)
    end
  end

  shared_examples_for "displays the settings" do |setting, value|
    it "displays the label for #{setting}" do
      render
      response.should contain(I18n.t("activerecord.attributes.setting.#{setting}"))
    end

    it "displays an input field for #{setting}" do
      render
      if value.nil?
        response.should have_selector("input", :name => "setting[#{setting}]")
      else
        response.should have_selector("input", :name => "setting[#{setting}]", :value => value)
      end
    end
  end

  {:flickr_user => 'user', :flickr_api_key => '1234', :flickr_shared_secret => '5678', :page_title => 'page title', :post_more_separator => '!!more!!'}.each do |key, value|
    it_behaves_like "displays the settings", key, value
  end

  [:admin_password, :admin_password_confirmation].each do |key|
    it_behaves_like "displays the settings", key, nil
  end

  it "should not have missing translations" do
    render
    response.should_not contain("translation missing")
  end
end
