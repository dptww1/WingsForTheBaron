class SingularizeGamesPlayersOrders1Orders2 < ActiveRecord::Migration
  def change
    rename_column :games_players, :orders1, :order1
    rename_column :games_players, :orders2, :order2
  end
end
