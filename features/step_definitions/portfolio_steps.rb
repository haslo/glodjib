Given(/^I have at least (\d+) Flickr cache entries$/) do |count|
  1.upto(count.to_i).each do |index|
    FlickrAPI.new.find_or_create_cache("testtag#{index}", "test-user #{index}")
  end
end

Then(/^there should be exactly (\d+) Flickr cache entries$/) do |count|
  FlickrCache.count.should == count.to_i
end

Then(/^I should see at least (\d+) portfolio image thumbnail$/) do |count|
  page.all('img.portfolio_thumbnail').count.should >= count.to_i
end