class Game < ActiveRecord::Base
  belongs_to :creator, :class_name => "User", :foreign_key => "creator", :inverse_of => :created

  has_many :games_players
  has_many :users, :through => :games_players

  attr_accessible :creator
  attr_accessible :name

  validates :name, :presence => true
  validates :creator, :presence => true

  validate :at_least_two_players

  after_initialize :set_defaults, :if => :new_record?

  def self.player_names ; %w/Albatros Fokker Halberstadt Pfalz/; end

  def albatros
    games_players.each { |p| return p if p.side_name == "Albatros" }
    nil
  end

  def fokker
    games_players.each { |p| return p if p.side_name == "Fokker" }
    nil
  end

  def halberstadt
    games_players.each { |p| return p if p.side_name == "Halberstadt" }
    nil
  end

  def pfalz
    games_players.each { |p| return p if p.side_name == "Pfalz" }
    nil
  end

  def each_player
    games_players.each do |gp| yield gp.side_name, gp.player end
  end

  def at_least_two_players
    errors.add(:base, "You must have at least two players") unless games_players.size >= 2
  end

  def set_defaults
    self.allied_morale  = 25
    self.allied_power   = 4
    self.complete       = false
    # contracts_available depends on number of players
    self.contracts_left = 0
    # creator is filled in by controller
    self.games_players  = []
    self.german_morale  = 25
    self.inflation      = 0
    self.turn           = 1
  end
end
