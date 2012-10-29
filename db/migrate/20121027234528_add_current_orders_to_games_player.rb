class AddCurrentOrdersToGamesPlayer < ActiveRecord::Migration
  def change
    add_column :games_players, :orders1, :string
    add_column :games_players, :orders2, :string
  end
end
