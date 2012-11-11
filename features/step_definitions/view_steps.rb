Then /^I should see "(.*)"$/ do |name|
  page.should have_content(name)
end

Then /^I should not see "(.*)"$/ do |name|
  page.should_not have_content(name)
end

Then /^I should see my orders drop down menus$/ do
  page.should have_content(@current_user_email)
  current_user = User.where(:email => @current_user_email).first
  page.has_selector? "form#edit_games_player#{current_user.id} #games_player_order1_input"
  page.has_selector? "form#edit_games_player#{current_user.id} #zzzzzzzzzzzzgames_player_order3_input"
end

Then /^I should see a notification on "(.*)"/ do |game_name|
  within :xpath, "//td/a[text()='#{game_name}']/../.." do  # get row containing game name
    page.should have_content("!")
  end
end

Then /^I should not see a notification on "(.*)"/ do |game_name|
  within :xpath, "//td/a[text()='#{game_name}']/../.." do
    page.should_not have_content("!")
  end
end
