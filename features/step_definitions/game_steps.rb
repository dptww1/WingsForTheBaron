Given /^I have (a )?games? named (.+)$/ do |article, names|
  names.split(/\s*,\s*/).each do |name|
    Game.create!(:name => name, :creator => 1)
  end
end

Then /^I should see "(.*)"$/ do |name|
  page.should have_content(name)
end

Then /^I should not see "(.*)"$/ do |name|
  page.should_not have_content(name)
end
