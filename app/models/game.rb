class Game < ActiveRecord::Base
  attr_accessible :allied_morale, :allied_power, :complete, :contracts_available, :contracts_used, :german_morale, :inflation, :name, :turn

  validates :name, :presence => true

  after_initialize :my_after_initialize

  def my_after_initialize
    if new_record?
      self.allied_morale = 25
      self.allied_power  = 4
      self.complete      = false
      self.german_morale = 25
      self.inflation     = 0
      self.turn          = 1
    end
  end
end
