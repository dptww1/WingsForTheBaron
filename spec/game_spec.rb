require "spec_helper"

describe "Games" do
  before(:each) do
    @g = Game.new
  end
  
  describe "New game" do
    it "should have initialized attributes" do
      @g.allied_morale.should  == 25
      @g.allied_power.should   ==  4
      @g.complete.should       == false
      @g.german_morale.should  == 25
      @g.inflation.should      == 0
      @g.turn.should           == 1
    end

    it "should have 16 war status cards in the draw pile" do
      @g.war_status_card_draws.size.should == 16
    end
  end

end
