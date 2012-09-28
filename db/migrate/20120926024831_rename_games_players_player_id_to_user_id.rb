class RenameGamesPlayersPlayerIdToUserId < ActiveRecord::Migration
  def up
    rename_column :games_players, :player_id, :user_id
  end

  def down
    rename_column :games_players, :user_id, :player_id
  end
end
