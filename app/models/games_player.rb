class GamesPlayer < ActiveRecord::Base
  belongs_to :game, :inverse_of => :games_players
  belongs_to :user, :inverse_of => :games_players

  attr_accessible :game, :user
  attr_accessible :game_id, :user_id
  attr_accessible :side_name

  after_initialize :set_defaults, :if => :new_record?

  def set_defaults
    self.bank      = 0
    self.factories = 1
    self.power     = 3
    self.score     = 0
  end
end
