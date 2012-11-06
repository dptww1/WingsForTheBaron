class CreateJournalItems < ActiveRecord::Migration
  def change
    create_table :journal_items do |t|
      t.integer :game_id
      t.string :item_type
      t.string :arg1
      t.string :arg2
      t.string :arg3
      t.string :arg4

      t.timestamps
    end
  end
end
