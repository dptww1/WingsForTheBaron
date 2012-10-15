class AddWinnerToGamesPlayers < ActiveRecord::Migration
  def change
    add_column :games_players, :winner, :boolean
  end
end
