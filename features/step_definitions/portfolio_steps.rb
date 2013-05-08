Then(/^I should see at least (\d+) portfolio image thumbnail$/) do |count|
  page.all('img.portfolio_thumbnail').count.should >= count.to_i
end