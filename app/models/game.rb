class Game < ActiveRecord::Base
  belongs_to :user, :foreign_key => :creator

  attr_accessor   :allied_morale
  attr_accessor   :allied_power
  attr_accessor   :complete 
  attr_accessor   :contracts_available
  attr_accessor   :contracts_left
  attr_accessible :creator
  attr_accessor   :german_morale
  attr_accessor   :inflation
  attr_accessible :name
  attr_accessor   :turn

  validates :name, :presence => true
  validates :creator, :presence => true

  after_initialize do |rec|
    if new_record?
      rec.allied_morale  = 25
      rec.allied_power   = 4
      rec.complete       = false
      # contracts_available depends on number of players
      rec.contracts_left = 0
      # creator is filled in by controller
      rec.german_morale  = 25
      rec.inflation      = 0
      rec.turn           = 1
    end
  end
end
