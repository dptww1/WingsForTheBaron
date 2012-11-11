Given /^these users:$/ do |tbl|
  tbl.hashes.each do |h|
    User.create(:email => h["name"], :password => h["name"], :password_confirmation => h["name"])
  end
end

Given /^I have (a )?games? named (.+)$/ do |article, names|
  user1 = User.where(:email => "test1@example.com").first
  user2 = User.where(:email => "test2@example.com").first
  user3 = User.where(:email => "test3@example.com").first
  user4 = User.where(:email => "test4@example.com").first

  names.gsub!("\"", "").split(/\s*,\s*/).each do |name|
    g = Game.create(:name => name)
    g.creator = user2
    g.games_players.build(:user => user1, :side_name => "Albatros")
    g.games_players.build(:user => user2, :side_name => "Fokker")
    g.games_players.build(:user => user3, :side_name => "Halberstadt")
    g.games_players.build(:user => user4, :side_name => "Pfalz")
    g.save!
  end
end

# Followed by table with columns "side" (Albatros|Fokker|Halberstadt|Pfalz) and "name" (email)
When /^I create a game named "(.*)" with these players:/ do |name, table|
  visit new_game_url

  fill_in "Game Name", :with => name

  table.hashes.each do |h|
    fill_in h["side"], :with => h["name"]
  end

  click_button "Create Game"

  @cuke_game_id = Rails.application.routes.recognize_path(current_path)[:id]
end

When /^I update the game with these players:$/ do |table|
  @game = Game.find(@cuke_game_id)

  visit edit_game_path(@game)

  table.hashes.each do |h|
    fill_in h["side"], :with => h["name"]
  end

  click_button "Update Game"
end
