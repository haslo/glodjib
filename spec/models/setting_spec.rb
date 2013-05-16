require 'spec_helper'

describe Setting, :blub => true do
  it { should validate_presence_of :key }
  it { should validate_presence_of :value }

  it { should validate_uniqueness_of(:key) }

  it "accepts keys and values for #put and returns the value" do
    Setting.put("key", "value").should == "value"
  end

  it "stores settings as key-value pairs when #put is called" do
    expect { Setting.put("key", "value") }.to change(Setting, :count).from(0).to(1)
  end

  it "stores the correct value for a key through #method_missing" do
    Setting.send(:key=, "value")
    Setting.where("`key` = ?", "key").first.value.should == "value"
  end

  it "retreives the correct value through #method_missing" do
    Setting.send(:key=, "value")
    Setting.send(:key).should == "value"
  end
end
