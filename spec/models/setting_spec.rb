require 'spec_helper'

describe Setting, :issue23 => true do
  it { should validate_presence_of :key }
  it { should validate_presence_of :value }

  it { should validate_uniqueness_of(:key) }

  describe 'standard functionality' do
    it 'accepts keys and values with #method_missing assignment and returns the value' do
      (Setting.item = 'value').should == 'value'
    end

    it 'stores settings as key-value pairs with #method_missing assignment' do
      expect { Setting.item = 'value' }.to change(Setting, :count).from(0).to(1)
    end

    it 'stores the correct value for a key through #method_missing' do
      Setting.send(:item=, 'value')
      Setting.where(:key => 'item').first.value.should == 'value'
    end

    it 'retrieves the correct value through #method_missing' do
      Setting.send(:item=, 'value')
      Setting.item.should == 'value'
    end
  end

  describe 'admin password functionality' do
    it 'does not assign a regular Setting pair for #admin_password=' do
      expect { Setting.new.admin_password = 'test' }.to_not change(Setting, :count)
    end

    it 'does not assign a regular Setting pair for #admin_password_confirmation=' do
      expect { Setting.new.admin_password = 'test' }.to_not change(Setting, :count)
    end

    it 'saves the password to the first user' do
      user = User.create!(:email => 'test@mail.com', :password => '12345678', :password_confirmation => '12345678')
      encrypted_password = user.encrypted_password
      setting = Setting.new
      setting.admin_password = '87654321'
      setting.admin_password_confirmation = '87654321'
      setting.save_admin_password
      encrypted_password.should_not == User.first.encrypted_password
    end
  end
end
