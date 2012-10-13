require "spec_helper"

describe Game do
  before(:each) do
    user1 = User.create!(email: "rspec1@example.com", password: "rspec1@ex", password_confirmation: "rspec1@ex")
    user2 = User.create!(email: "rspec2@example.com", password: "rspec1@ex", password_confirmation: "rspec1@ex")
    user3 = User.create!(email: "rspec3@example.com", password: "rspec1@ex", password_confirmation: "rspec1@ex")

    @game = Game.create(name: "RSpec Game", creator: user2)
    @game.games_players << GamesPlayer.create!(user: user1, side_name: "albatros")
    @game.games_players << GamesPlayer.create!(user: user2, side_name: "fokker")
    @game.games_players << GamesPlayer.create!(user: user3, side_name: "pfalz")

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
  end
end
