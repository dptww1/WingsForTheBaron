Given /^I have (a )?games? named (.+)$/ do |article, names|
  names.gsub!("\"", "").split(/\s*,\s*/).each do |name|
    Game.create!(:name => name, :creator => 1)
  end
end

When /^I create a game named "(.*)" with players (Albatros)?(?:, )?(Fokker)?(?:, )?(Halberstadt)?(?:, )?(Pfalz)?/ do |name, alb, fok, halb, pfa|
  visit new_game_url
  fill_in "Game Name", :with => name
  click_button "Create Game"
  @cuke_game_id = Rails.application.routes.recognize_path(current_path)[:id]
end
