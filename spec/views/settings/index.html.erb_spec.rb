require 'spec_helper'

describe "settings/index.html.erb", :blub => true do
  before(:each) do
    {:flickr_api_key => '1234', :flickr_shared_secret => '5678', :page_title => 'page title', :post_more_separator => '!!more!!'}.each do |key, value|
      Setting.put(key, value)
    end
  end

  shared_examples_for "displays the settings" do |setting, value|
    it "should display the label for #{setting}" do
      render
      response.should contain(I18n.t("activerecord.attributes.setting.#{setting}"))
    end

    it "displays a text field for #{setting}" do
      render
      response.should have_selector("input", :type => "text", :name => "setting[#{setting}]", :value => value)
    end
  end

  {:flickr_api_key => '1234', :flickr_shared_secret => '5678', :page_title => 'page title', :post_more_separator => '!!more!!'}.each do |key, value|
    it_behaves_like "displays the settings", key, value
  end

  it "should not have missing translations" do
    render
    response.should_not contain("translation missing")
  end
end
