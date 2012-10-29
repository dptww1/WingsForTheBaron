class SingularizeGamesPlayersOrdersOrders2 < ActiveRecord::Migration
  def change
    rename_column :games_players_orders, :orders2, :order2
  end
end
