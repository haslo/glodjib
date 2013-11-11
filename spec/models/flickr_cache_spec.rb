require 'spec_helper'

describe FlickrCache do
  let(:new_valid_record) { FlickrCache.new(:flickr_user => FlickrUser.new(:username => 'username'), :flickr_tag => FlickrTag.new(:tag_name => 'tag')) }

  it { should belong_to(:flickr_user) }
  it { should belong_to(:flickr_tag) }

  it { should validate_presence_of :flickr_user }
  it { should validate_presence_of :flickr_tag }

  describe 'timeout functionality' do
    it 'timeout is set to nil when created' do
      record = new_valid_record
      record.timeout.should == nil
    end

    it 'timeout_over? returns true after creation' do
      record = new_valid_record
      record.should be_timeout_over
    end

    it 'timeout_over? returns true after 24 hours' do
      record = new_valid_record
      record.timeout = Time.now - 1.minute
      record.should be_timeout_over
    end

    it 'resets the timeout to 24 hours upon a call to refresh_timeout' do
      record = new_valid_record
      record.timeout = Time.now - 1.minute
      record.refresh_timeout
      record.timeout.should <= Time.now + 24.hours
      record.timeout.should > Time.now + 23.hours
    end

    it 'timeout_over? returns false after a fresh call to refresh_timeout' do
      record = new_valid_record
      record.timeout = Time.now - 1.minute
      record.refresh_timeout
      record.should_not be_timeout_over
    end
  end
end
