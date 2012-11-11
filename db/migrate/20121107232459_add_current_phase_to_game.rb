class AddCurrentPhaseToGame < ActiveRecord::Migration
  def change
    add_column :games, :current_phase, :string
  end
end
