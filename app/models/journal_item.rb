# Possible journal items
#
# item_type         | arg1          | arg2             | arg3             |  arg4     | comments
# ------------------+---------------+------------------+------------------+-----------+---------
# orders            | side name     | order1           | order2           | -         | orders set
class JournalItem < ActiveRecord::Base
  belongs_to :game

  validates :item_type, :presence => true
  validates :turn,   :presence => true

  attr_accessible :arg1, :arg2, :arg3, :arg4, :game_id, :item_type, :turn

  def event_text
    case self.item_type
    when "allied_leap"       then "Allies get technological leap to #{self.arg1} Power (was #{self.arg2}, max player power #{self.arg3}, dieroll #{self.arg4})"
    when "allied_morale"     then "Allied Morale lowered by #{self.arg1} to #{self.arg2}"
    when "allied_new_ac"     then "Allies deploy new aircraft of #{self.arg1} Power, dieroll was #{self.arg2}"
    when "allied_no_upgrade" then "Allies failed to upgrade Power because they were already ahead #{self.arg1} to #{self.arg2})"
    when "allied_upgrade"    then "Allies upgraded to #{self.arg1} Power (was #{self.arg2}, max player power #{self.arg3}, dieroll #{self.arg4}"
    when "german_morale"     then "German Morale lowered by #{self.arg1} to #{self.arg2}"
    when "inflation"         then "Inflation rises to #{self.arg1.to_i * 10}%"
    when "init"              then "Started game, Albatros=#{self.arg1}, Fokker=#{self.arg2}, Halberstadt=#{self.arg3}, Pfalz=#{self.arg4}"
    when "new_contracts"     then "Contracts available now #{self.arg1} (added #{self.arg2} less #{self.arg3} unfulfilled contracts this turn)"
    when "new_turn"          then "Advanced to turn #{self.arg1}"
    when "orders"            then "#{self.arg1} entered orders #{self.arg2} and #{self.arg3}"  # TODO: hide current orders
    when "reshuffle"         then "Reshuffling War Status Cards"
    when "war_status"        then "Drew War Status Card #{self.arg1}, '#{self.arg2}'"
    else
      "No formatting available for type #{self.item_type}"
    end
  end
end
