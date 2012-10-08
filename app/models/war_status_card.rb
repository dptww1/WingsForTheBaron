class WarStatusCard < ActiveRecord::Base
  has_and_belongs_to_many :game_draws, :class_name => "Game"

  attr_accessible :allied_morale_loss
  attr_accessible :allied_technology_leap 
  attr_accessible :do_inflation 
  attr_accessible :do_reshuffle 
  attr_accessible :german_morale_loss 
  attr_accessible :new_allied_ac 
  attr_accessible :new_contracts
  attr_accessible :title 
  attr_accessible :upgraded_allied_ac
end
