class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :turn
      t.integer :allied_power
      t.integer :german_morale
      t.integer :allied_morale
      t.integer :inflation
      t.integer :contracts_available
      t.integer :contracts_used
      t.boolean :complete

      t.timestamps
    end
  end
end
