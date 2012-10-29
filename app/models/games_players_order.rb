class GamesPlayersOrder < ActiveRecord::Base
  belongs_to :games_player

  attr_accessible :order1, :order2, :turn
  attr_accessor :games_player_id

  def self.options
    %w/None Build Spy Design Research Bank/
  end
end
