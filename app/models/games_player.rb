class GamesPlayer < ActiveRecord::Base
  belongs_to :game, :inverse_of => :games_players
  belongs_to :user, :inverse_of => :games_players

  has_many :games_players_orders

  accepts_nested_attributes_for :games_players_orders

  validates :order1, :presence => true, :inclusion => { in: GamesPlayersOrder::options }
  validates :order2, :presence => true, :inclusion => { in: GamesPlayersOrder::options }
  validates :user,   :presence => true

  attr_accessible :game, :user
  attr_accessible :game_id, :user_id
  attr_accessible :side_name
  attr_accessible :order1, :order2

  after_initialize :set_defaults, :if => :new_record?

  def has_current_orders?
    self.order1 != "None" && self.order2 != "None"
  end

  def set_defaults
    self.bank      = 0
    self.factories = 1
    self.order1    = "None"
    self.order2    = "None"
    self.power     = 3
    self.score     = 0
    self.winner    = false
  end
end
