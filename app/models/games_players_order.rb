class GamesPlayersOrder < ActiveRecord::Base
  def self.options
    %w/None Build Spy Design Research Bank/
  end

  belongs_to :games_player

  validates :order1, :presence => true, :inclusion => { in: options }
  validates :order2, :presence => true, :inclusion => { in: options }

  attr_accessible :order1, :order2, :turn
  attr_accessor :games_player_id
end
