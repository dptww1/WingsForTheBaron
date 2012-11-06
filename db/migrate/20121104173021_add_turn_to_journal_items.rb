class AddTurnToJournalItems < ActiveRecord::Migration
  def change
    add_column :journal_items, :turn, :integer
  end
end
