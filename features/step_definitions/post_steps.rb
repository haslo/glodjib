Given /^I have posts titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
    Post.create!(:title => title)
  end
end

Given /^I have no posts$/ do
  Post.delete_all
end

Then /^I should have ([0-9]+) posts?$/ do |count|
  Post.count.should == count.to_i
end