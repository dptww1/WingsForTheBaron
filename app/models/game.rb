class Game < ActiveRecord::Base
  belongs_to :creator, :class_name => "User", :foreign_key => "creator", :inverse_of => :created

  has_many :games_players
  has_many :users, :through => :games_players
  has_and_belongs_to_many :war_status_card_draws, :class_name => "WarStatusCard", :join_table => :games_war_status_draws

  attr_accessible :creator
  attr_accessible :name

  validates :name, :presence => true
  validates :creator, :presence => true

  validate :at_least_two_players

  after_initialize :set_defaults, :if => :new_record?

  def self.player_names ; %w/Albatros Fokker Halberstadt Pfalz/; end

  def find_player_by_side_name(side_name)
    games_players.each { |p| return p if p.side_name.upcase == side_name.upcase }
    nil
  end

  def albatros
    games_players.each { |p| return p.user.email if p.side_name == "Albatros" }
    nil
  end

  def fokker
    games_players.each { |p| return p.user.email if p.side_name == "Fokker" }
    nil
  end

  def halberstadt
    games_players.each { |p| return p.user.email if p.side_name == "Halberstadt" }
    nil
  end

  def pfalz
    games_players.each { |p| return p.user.email if p.side_name == "Pfalz" }
    nil
  end

  def execute_war_status_card(card)
    if card.do_inflation
      self.inflation += 1 
      # TODO reduce player's Score
    end

    self.german_morale = [self.german_morale - card.german_morale_loss, 0].max

    self.allied_morale = [self.allied_morale - card.allied_morale_loss, 0].max

    self.contracts_available += [card.new_contracts - self.contracts_left, 0].max

    if card.do_reshuffle
      war_status_card_draws.clear
      war_status_card_draws << WarStatusCard.all
    end

    if card.upgraded_allied_ac && allied_power < max_player_power
      self.allied_power = allied_power + (1..6).to_a.sample

    elsif card.new_allied_ac
      self.allied_power = self.allied_power + (1..6).to_a.sample

    elsif card.allied_technology_leap
      self.allied_power = [self.allied_power, max_player_power].max + (1..6).to_a.sample
    end

    # TODO power bonus to morale
    # TODO game over? (including extra inflation)
    # TODO save game state
  end
  
  # Parameter is for testing purposes
  def draw_war_status_card(card_num=nil)
    card = card_num ? war_status_card_draws.find { |c| c.card_num == card_num } : war_status_card_draws.sample
    war_status_card_draws.delete card
    card
  end

  def max_player_power
    games_players.inject(0) { |sum, player| sum += player.power }
  end

  def at_least_two_players
    errors.add(:base, "You must have at least two players") unless games_players.size >= 2
  end

  def set_defaults
    self.allied_morale       = 25
    self.allied_power        = 4
    self.complete            = false
    self.contracts_available = 4 # TODO: should depend on number of players
    self.contracts_left      = 0
    # creator is filled in by controller
    self.games_players       = []
    self.german_morale       = 25
    self.inflation           = 0
    self.turn                = 1

    self.war_status_card_draws << WarStatusCard.all
  end
end
