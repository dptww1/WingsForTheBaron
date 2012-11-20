require "spec_helper"

describe Game do
  before(:each) do
    user1 = User.create!(email: "rspec1@example.com", password: "rspec1@ex", password_confirmation: "rspec1@ex")
    user2 = User.create!(email: "rspec2@example.com", password: "rspec1@ex", password_confirmation: "rspec1@ex")
    user3 = User.create!(email: "rspec3@example.com", password: "rspec1@ex", password_confirmation: "rspec1@ex")

    @game = Game.new(name: "RSpec Game", creator: user2)

    @game.games_players.build(user: user1, side_name: "Albatros")
    @game.games_players.build(user: user2, side_name: "Fokker")
    # no Halberstadt
    @game.games_players.build(user: user3, side_name: "Pfalz")

    @game.save!
    @initial_timestamp = DateTime.now
  end

  it "has initialized attributes" do
    @game.allied_morale.should  == 25
    @game.allied_power.should   ==  4
    @game.complete.should       == false
    @game.german_morale.should  == 25
    @game.inflation.should      == 0
    @game.turn.should           == 1
    @game.current_phase.should  == "orders"
    end

  it "should have a single 'game initialized' journal item" do
    @game.journal_items.size.should         == 1
    @game.journal_items[0].should           be_valid
    @game.journal_items[0].item_type.should == "init"
    @game.journal_items[0].arg1.should      == "rspec1@example.com"
    @game.journal_items[0].arg2.should      == "rspec2@example.com"
    @game.journal_items[0].arg3.should      be_nil
    @game.journal_items[0].arg4.should      == "rspec3@example.com"
  end

  it "should have 16 war status cards in the draw pile" do
    @game.war_status_card_draws.size.should == 16
  end

  it "should have default orders for all players" do
    @game.games_players.each do |gp|
      gp.order1.should == "None"
      gp.order2.should == "None"
    end
  end

  describe "#draw_war_status_card" do
    it "removes a card from the War Status deck" do
      num_cards = @game.war_status_card_draws.size
      card = @game.draw_war_status_card
      card.should_not be_nil
      @game.war_status_card_draws.size().should == num_cards - 1
    end
  end

  describe "#execute_war_status_card" do
    it "archives the current orders" do
      @game.games_players.each { |gp| gp.games_players_orders.size.should == 0 }
      card = @game.draw_war_status_card
      @game.execute_war_status_card(card)
      @game.games_players.each { |gp| gp.games_players_orders.size.should == 1 }
    end

    it "lowers the morale of both sides" do
      Kernel.sleep(1)  # give "now" time to be past game save time
      now = DateTime.now
      card = @game.draw_war_status_card
      # make sure all the flags are turned off to ensure that only moral emessages are added to the log
      card.upgraded_allied_ac = false
      card.new_allied_ac = false
      card.allied_technology_leap = false
      card.do_inflation = false
      @game.execute_war_status_card(card)

      @game.allied_morale.should be < 25
      @game.german_morale.should be < 25
      @game.new_journal_items(now).size.should >= 3
    end

    it "adds inflation when required" do
      @game.execute_war_status_card(WarStatusCard.where(card_num: 1).first)  # no inflation
      @game.inflation.should == 0

      @game.execute_war_status_card(WarStatusCard.where(card_num: 7).first)  # inflation
      @game.inflation.should == 1
    end

    it "adds new contracts, less this turn's unawarded contracts" do
      card = WarStatusCard.where(card_num: 3).first   # new_contracts == 3
      @game.contracts_available = 42

      @game.contracts_left = 0  # all contracts awarded
      @game.execute_war_status_card(card)
      @game.contracts_available.should == 45

      @game.contracts_left = 1  # so 3 new contracts, less 1 remaining == 2
      @game.execute_war_status_card(card)
      @game.contracts_available.should == 47 # 45 + 2

      @game.contracts_left = 3  # 3 new contracts less 3 remaining == 0
      @game.execute_war_status_card(card)
      @game.contracts_available.should == 47 # 47 + 0
    end

    it "reshuffles when required" do
      @game.execute_war_status_card(@game.draw_war_status_card(3))   # no reshuffle
      @game.war_status_card_draws.size.should == 15   # full deck of sixteen, less one

      @game.execute_war_status_card(@game.draw_war_status_card(1))  # reshuffle
      @game.war_status_card_draws.size.should == 16   # all cards back in deck
    end

    it "ends the game when german morale drops to 0" do
      @game.german_morale = 4
      @game.execute_war_status_card(@game.draw_war_status_card(16))
      @game.complete.should be_true
    end

    it "ends the game when allied morale drops to 0" do
      @game.allied_morale = 4
      @game.execute_war_status_card(@game.draw_war_status_card(16))
      @game.complete.should be_true
    end

    it "ends the game when inflation reaches 100%" do
      @game.inflation = 9
      @game.execute_war_status_card(@game.draw_war_status_card(15))
      @game.complete.should be_true
    end

    it "adds new empty player orders for the current turn" do
      @game.execute_war_status_card(@game.draw_war_status_card)
      @game.games_players.each do |gp|
        gp.order1 = "None"
        gp.order2 = "None"
      end
    end
  end

  describe "#new_journal_items" do
    it "finds the 'init' item for a new game" do
      @game.new_journal_items(@initial_timestamp).size.should == 1
      @game.new_journal_items(@initial_timestamp)[0].item_type.should == "init"
    end
  end

  describe "#check_all_orders_in" do
    it "doesn't update the current_phase when no players have entered orders" do
      @game.check_all_orders_in!
      @game.current_phase.should == "orders"
    end

    it "doesn't update the current_phase when some players have entered orders" do
      @game.albatros.update_attributes!(order1: "Build", order2: "Build")
      @game.pfalz.update_attributes!(order1: "Research", order2: "Research")
      @game.check_all_orders_in!
      @game.current_phase.should == "orders"
    end

    it "does update the current_phase when all players have entered orders" do
      @game.albatros.update_attributes!(order1: "Build", order2: "Build")
      @game.fokker.update_attributes!(order1: "Spy", order2: "Spy")
      @game.pfalz.update_attributes!(order1: "Research", order2: "Research")
      @game.check_all_orders_in!
      @game.current_phase.should == "implement"
    end
  end

  describe "#decide_winner" do
    it "marks player with highest Bank + Score as winner" do
      @game.games_players.each { |gp| gp.winner.should be_false }

      @game.albatros.bank  = 3
      @game.albatros.score = 4    # == 7

      @game.fokker.bank  = 2
      @game.fokker.score = 9      # == 11

      @game.pfalz.bank  = 8
      @game.pfalz.score = 2       # == 10

      @game.decide_winner

      @game.albatros.winner.should be_false
      @game.fokker.winner.should be_true
      @game.pfalz.winner.should be_false
    end

    it "allows ties" do
      @game.games_players.each { |gp| gp.winner.should be_false }

      @game.albatros.bank  = 3
      @game.albatros.score = 4    # == 7

      @game.fokker.bank  = 2
      @game.fokker.score = 9      # == 11

      @game.pfalz.bank  = 6
      @game.pfalz.score = 5       # == 11

      @game.decide_winner

      @game.albatros.winner.should be_false
      @game.fokker.winner.should be_true
      @game.pfalz.winner.should be_true
    end
  end
end
