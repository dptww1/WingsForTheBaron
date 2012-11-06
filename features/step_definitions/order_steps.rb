When /^I set my orders to "(\w+)" and "(\w+)"$/ do |order1, order2|
  select order1, :from => "games_player_order1"
  select order2, :from => "games_player_order2"
  click_button "Done"
end
