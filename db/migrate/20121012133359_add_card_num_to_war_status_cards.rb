class AddCardNumToWarStatusCards < ActiveRecord::Migration
  def change
    add_column :war_status_cards, :card_num, :integer
  end
end
