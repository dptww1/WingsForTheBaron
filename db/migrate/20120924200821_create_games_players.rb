class CreateGamesPlayers < ActiveRecord::Migration
  def change
    create_table :games_players do |t|
      t.integer :game_id
      t.integer :player_id
      t.string :side_name
    end
  end
end
