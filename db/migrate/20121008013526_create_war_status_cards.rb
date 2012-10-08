class CreateWarStatusCards < ActiveRecord::Migration
  def change
    create_table :war_status_cards do |t|
      t.string :title
      t.boolean :do_inflation
      t.integer :allied_morale_loss
      t.integer :german_morale_loss
      t.integer :new_contracts
      t.boolean :do_reshuffle
      t.boolean :upgraded_allied_ac
      t.boolean :new_allied_ac
      t.boolean :allied_technology_leap
    end
  end
end
