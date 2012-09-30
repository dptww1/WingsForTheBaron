Given /^I have (a )?games? named (.+)$/ do |article, names|
  user1 = User.create!(:email => "test1@example.com", :password => "test123", :password_confirmation => "test123")
  user2 = User.create!(:email => "test2@example.com", :password => "test456", :password_confirmation => "test456")
  user3 = User.create!(:email => "test3@example.com", :password => "test789", :password_confirmation => "test789")
  user4 = User.create!(:email => "test4@example.com", :password => "test0ab", :password_confirmation => "test0ab")

  names.gsub!("\"", "").split(/\s*,\s*/).each do |name|
    g = Game.create(:name => name)
    g.creator = user2
    g.games_players << GamesPlayer.create(:user => user1, :side_name => "albatros")
    g.games_players << GamesPlayer.create(:user => user2, :side_name => "fokker")
    g.games_players << GamesPlayer.create(:user => user3, :side_name => "halberstadt")
    g.games_players << GamesPlayer.create(:user => user4, :side_name => "pfalz")
    g.save!
  end
end

# Kinda weak. Because of the way pattern matching works, you have to create players in order; in other words, 
# you can't have Albatros, Fokker and Pfalz.  The regexp matches correctly but the "alb", "fok", and "halb"
# variables will be populated, not "alb", "fok", and "pfa".
When /^I create a game named "(.*)" with players (Albatros)?(?:, )?(Fokker)?(?:, )?(Halberstadt)?(?:, )?(Pfalz)?/ do |name, alb, fok, halb, pfa|
  user1 = User.create!(:email => "test5@example.com", :password => "test123", :password_confirmation => "test123")
  user2 = User.create!(:email => "test6@example.com", :password => "test456", :password_confirmation => "test456")
  user3 = User.create!(:email => "test7@example.com", :password => "test789", :password_confirmation => "test789")
  user4 = User.create!(:email => "test8@example.com", :password => "test0ab", :password_confirmation => "test0ab")

  visit new_game_url
  fill_in "Game Name",   :with => name 
  fill_in "Albatros",    :with => user1.email if alb
  fill_in "Fokker",      :with => user2.email if fok
  fill_in "Halberstadt", :with => user3.email if halb
  fill_in "Pfalz",       :with => user4.email if pfa
  click_button "Create Game"

  @cuke_game_id = Rails.application.routes.recognize_path(current_path)[:id]
end
