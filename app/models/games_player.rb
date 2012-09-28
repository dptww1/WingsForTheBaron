class GamesPlayer < ActiveRecord::Base
  belongs_to :game, :inverse_of => :games_players
  belongs_to :user, :inverse_of => :games_players

  attr_accessible :game, :user, :user_id
  attr_accessible :game_id, :side_name
  attr_accessible :bank, :factories, :power, :score
end
