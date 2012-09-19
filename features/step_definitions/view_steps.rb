Then /^I should see "(.*)"$/ do |name|
  page.should have_content(name)
end

Then /^I should not see "(.*)"$/ do |name|
  page.should_not have_content(name)
end
