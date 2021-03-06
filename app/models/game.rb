class Game < ActiveRecord::Base
  belongs_to :creator, :class_name => "User", :foreign_key => "creator", :inverse_of => :created

  has_many :journal_items
  has_many :games_players
  has_many :users, :through => :games_players
  has_and_belongs_to_many :war_status_card_draws, :class_name => "WarStatusCard", :join_table => :games_war_status_draws

  attr_accessible :creator
  attr_accessible :name

  validates :creator, :presence => true
  validates :name, :presence => true
  validate :at_least_two_players

  before_create    :create_initial_log_message
  after_initialize :set_defaults

  # Games that user is a participant in, whether or not (s)he owns the game
  scope :participating, lambda { |user| joins(:games_players).where("games_players.user_id = ?", user.id) }

  def self.player_names ; %w/Albatros Fokker Halberstadt Pfalz/; end

  def find_player_by_side_name(side_name)
    games_players.each { |p| return p if p.side_name.upcase == side_name.upcase }
    nil
  end

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

  def albatros_email
    albatros && albatros.user.email
  end

  def fokker_email
    fokker && fokker.user.email;
  end

  def halberstadt_email
    halberstadt && halberstadt.user.email
  end

  def pfalz_email
    pfalz && pfalz.user.email;
  end

  def decide_winner
    max_score = games_players.inject(0) { |max,gp| [max, gp.bank + gp.score].max }
    games_players.each do |gp|
      if max_score == gp.bank + gp.score
        gp.winner = true
      end
    end
  end

  def is_game_over
    return true if self.german_morale <= 0
    return true if self.allied_morale <= 0
    return true if self.inflation     >= 10
    false
  end

  def check_all_orders_in!
    unless games_players.find { |gp| !gp.has_current_orders? }
      self.current_phase = "implement"
    end
  end

  # Journal items created since this instance in memory was created (whether new or from the db)
  def new_journal_items(timestamp)
    journal_items.where("created_at >= ?", timestamp).order("id ASC")
  end

  def execute_war_status_card(card)
    log "war_status", card.card_num, card.title

    if card.do_inflation
      self.inflation += 1
      log "inflation", self.inflation
      # TODO reduce player's Score
    end

    self.german_morale = [self.german_morale - card.german_morale_loss, 0].max
    log "german_morale", card.german_morale_loss, self.german_morale

    self.allied_morale = [self.allied_morale - card.allied_morale_loss, 0].max
    log "allied_morale", card.allied_morale_loss, self.allied_morale

    self.contracts_available += [card.new_contracts - self.contracts_left, 0].max
    log "new_contracts", self.contracts_available, card.new_contracts, self.contracts_left

    if card.do_reshuffle
      war_status_card_draws.clear
      war_status_card_draws << WarStatusCard.all
      log "reshuffle"
    end

    if card.upgraded_allied_ac
      if self.allied_power < max_player_power
        d6 = (1..6).to_a.sample
        old_allied_power = self.allied_power
        self.allied_power += d6
        log "allied_upgrade", self.allied_power, old_allied_power, max_player_power, d6
      else
        log "allied_no_upgrade", self.allied_power, max_player_power
      end

    elsif card.new_allied_ac
      d6 = (1..6).to_a.sample
      self.allied_power = self.allied_power + d6
      log "allied_new_ac", self.allied_power, d6

    elsif card.allied_technology_leap
      d6 = (1..6).to_a.sample
      old_allied_power = self.allied_power
      self.allied_power = [self.allied_power, max_player_power].max + (1..6).to_a.sample
      log "allied_leap", self.allied_power, old_allied_power, max_player_power, d6
    end

    # TODO power bonus to morale
    # TODO game over? (including extra inflation)
    # TODO mark winner
    self.complete = is_game_over

    # Archive the orders for future reference and reset them for the new turn
    games_players.each do |gp|
      gp.games_players_orders << GamesPlayersOrder.create(order1: gp.order1, order2: gp.order2, turn: self.turn)
      gp.order1 = gp.order2 = "None"
    end

    # It's next turn!
    unless self.complete
      self.turn += 1
      log "new_turn", self.turn
    end
  end

  # Parameter is for testing purposes
  def draw_war_status_card(card_num=nil)
    card = card_num ? war_status_card_draws.find { |c| c.card_num == card_num } : war_status_card_draws.sample
    war_status_card_draws.delete card
    card
  end

  def action_required?(user)
    case self.current_phase
    when "orders"
      games_players.detect { |gp| gp.user == user && !gp.has_current_orders? }

    else
      false
    end
  end

  def max_player_power
    games_players.inject(0) { |sum, player| sum += player.power }
  end

  def at_least_two_players
    errors.add(:base, "You must have at least two players") unless games_players.size >= 2
  end

  def set_defaults
    if new_record?
      self.allied_morale       = 25
      self.allied_power        = 4
      self.complete            = false
      self.contracts_available = 4 # TODO: should depend on number of players
      self.contracts_left      = 0
      # creator is filled in by controller
      self.current_phase       = "orders"
      self.games_players       = []
      self.german_morale       = 25
      self.inflation           = 0
      self.turn                = 1

      self.war_status_card_draws << WarStatusCard.all
    end
  end

  def create_initial_log_message
    log "init", albatros_email, fokker_email, halberstadt_email, pfalz_email
  end

  def log(item_type, arg1=nil, arg2=nil, arg3=nil, arg4=nil)
    ji = journal_items.build(item_type: item_type, turn: turn, arg1: arg1, arg2: arg2, arg3: arg3, arg4: arg4)
    ji.save
  end
end
