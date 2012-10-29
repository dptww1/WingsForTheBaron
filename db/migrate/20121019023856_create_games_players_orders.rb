class CreateGamesPlayersOrders < ActiveRecord::Migration
  def change
    create_table :games_players_orders do |t|
      t.integer :games_player_id
      t.integer :turn
      t.string :order1  # using just :order causes SQL problems because it's a keyword

      t.timestamps
    end
  end
end
