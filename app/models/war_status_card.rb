class WarStatusCard < ActiveRecord::Base
  attr_accessible :allied_morale_loss, :allied_technology_leap, :do_inflation, :do_reshuffle, :german_morale_loss, :new_allied_ac, :new_contracts, :title, :upgraded_allied_ac
end
