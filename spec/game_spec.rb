require "spec_helper"

describe Game do
  before(:each) do
    user1 = User.create!(email: "rspec1@example.com", password: "rspec1@ex", password_confirmation: "rspec1@ex")
    user2 = User.create!(email: "rspec2@example.com", password: "rspec1@ex", password_confirmation: "rspec1@ex")
    user3 = User.create!(email: "rspec3@example.com", password: "rspec1@ex", password_confirmation: "rspec1@ex")

    @game = Game.create(name: "RSpec Game", creator: user2)
    @game.games_players << GamesPlayer.create!(user: user1, side_name: "Albatros")
    @game.games_players << GamesPlayer.create!(user: user2, side_name: "Fokker")
    @game.games_players << GamesPlayer.create!(user: user3, side_name: "Pfalz")

    @game.save!
  end

  it "has initialized attributes" do
    @game.allied_morale.should  == 25
    @game.allied_power.should   ==  4
    @game.complete.should       == false
    @game.german_morale.should  == 25
    @game.inflation.should      == 0
    @game.turn.should           == 1
    end

  it "should have 16 war status cards in the draw pile" do
    @game.war_status_card_draws.size.should == 16
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
    it "lowers the morale of both sides" do
      card = @game.draw_war_status_card
      card.upgraded_allied_ac = true
      card.new_allied_ac = true
      card.allied_technology_leap = true
      @game.execute_war_status_card(card)

      @game.allied_morale.should be < 25
      @game.german_morale.should be < 25
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
