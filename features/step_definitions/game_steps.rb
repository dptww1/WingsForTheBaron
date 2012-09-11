Given /^I have games named (.+)$/ do |names|
  names.split(/\s*,\s*/).each do |name|
    Game.create!(:name => name)
  end
end

Then /^I should see "(.*)"$/ do |name|
  page.should have_content(name)
end
