Given /^I have posts titled (.+) that say "(.+)"$/ do |titles, content|
  titles.split(', ').each do |title|
    post = Post.create!(:title => title, :content => content)
  end
end

Given(/^my "(.*?)" post has the tags (.+)$/) do |title, tags|
  tags.split(', ').each do |tag|
    Post.find_by_title(title).post_tags << PostTag.where("tag_text = ?", tag).first_or_create!(:tag_text => tag)
  end
end

Given(/^my post titled (.+) has (\d+) comments$/) do |title, number_of_comments|
  1.upto(number_of_comments.to_i).each do |index|
    Post.find_by_title(title).post_comments << PostComment.create!(:name => "Random name #{index}", :comment => "Random comment #{index}")
  end
end

Given(/^my post titled (.+) gets added a comment from "(.+)" that says "(.+)"$/) do |title, name, comment|
  Post.find_by_title(title).post_comments << PostComment.create!(:name => name, :comment => comment)
end

Given /^I have no posts$/ do
  Post.delete_all
end

Then /^I should have ([0-9]+) posts?$/ do |count|
  Post.count.should == count.to_i
end

Then /^I should have ([0-9]+) comments?$/ do |count|
  PostComment.count.should == count.to_i
end

Then /^I should have ([0-9]+) post tags?$/ do |count|
  PostTag.count.should == count.to_i
end
