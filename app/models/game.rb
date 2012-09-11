class Game < ActiveRecord::Base
  attr_accessible :allied_morale, :allied_power, :complete, :contracts_available, :contracts_used, :german_morale, :inflation, :name, :turn

end
