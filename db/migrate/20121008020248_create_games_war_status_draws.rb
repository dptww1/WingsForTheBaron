class CreateGamesWarStatusDraws < ActiveRecord::Migration
  def change
    create_table :games_war_status_draws, :id => false  do |t|
      t.integer :game_id
      t.integer :war_status_card_id
    end
  end
end
