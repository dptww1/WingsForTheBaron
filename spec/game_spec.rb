require "spec_helper"

describe "Games" do
  
  describe "New game" do
    it "should have initialized attributes" do
      g = Game.new
      g.allied_morale.should  == 25
      g.allied_power.should   ==  4
      g.complete.should       == false
      g.german_morale.should  == 25
      g.inflation.should      == 0
      g.turn.should           == 1
    end
  end

end
