class GameTouchups < ActiveRecord::Migration
  def change
    rename_column :games, :contracts_used, :contracts_left
    add_column    :games, :creator, :integer
  end
end
