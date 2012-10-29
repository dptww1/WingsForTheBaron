class AddOrders2ToGamesPlayersOrder < ActiveRecord::Migration
  def change
    add_column :games_players_orders, :orders2, :string
  end
end
