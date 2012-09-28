class AddFieldsToGamesPlayers < ActiveRecord::Migration
  def change
    add_column :games_players, :score, :integer
    add_column :games_players, :bank, :integer
    add_column :games_players, :power, :integer
    add_column :games_players, :factories, :integer
  end
end
