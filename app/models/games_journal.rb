class GamesJournal < ActiveRecord::Base
  belongs_to :game

  attr_accessible :event, :game_id
end
