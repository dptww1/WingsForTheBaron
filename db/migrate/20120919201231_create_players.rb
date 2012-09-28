class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :score
      t.integer :bank
      t.integer :power
      t.integer :factories

      t.timestamps
    end
  end
end
