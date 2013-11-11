require 'spec_helper'

describe ApplicationHelper do
  describe 'display_base_errors' do
    it 'should return an empty string without errors' do
      resource = double('Model').as_null_object
      resource.should_receive(:errors).at_least(:once).and_return({:messages => []})
      helper.display_base_errors(resource).should be_blank
    end

    it 'should return a string with all the errors if there are any' do
      resource = double('Model').as_null_object
      messages = ['first message', 'second message']
      resource.should_receive(:errors).at_least(:once).and_return({:messages => messages})
      return_value = helper.display_base_errors(resource)
      messages.each {|message| return_value.should =~ Regexp.new(message) }
    end
  end
end
