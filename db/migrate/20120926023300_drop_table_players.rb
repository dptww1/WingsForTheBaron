class DropTablePlayers < ActiveRecord::Migration
  def up
    drop_table :players
  end

  def down
    create_table :players do |t|
      t.add_column :score, :integer
      t.add_column :bank, :integer
      t.add_column :power, :integer
      t.add_column :factories, :integer
    end
  end
end
