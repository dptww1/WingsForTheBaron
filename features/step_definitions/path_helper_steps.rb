When /^I go to the list of games$/ do
  visit games_path
end

Then /^I should be on the show game page$/ do
  current_path.should == game_path(:id => @cuke_game_id)
end

When /^I am on the show game page$/ do
  visit game_path(:id => @cuke_game_id)
end
