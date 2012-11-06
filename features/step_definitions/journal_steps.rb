Then /^the game journal should contain "orders", "(\w+)", "(\w+)", "(\w+)"$/ do |side_name, order1, order2|
  game = Game.find(@cuke_game_id)
  item = game.journal_items.detect do |ji|
    ji.item_type == "orders"  &&
    ji.arg1      == side_name &&
    ji.arg2      == order1    &&
    ji.arg3      == order2
  end
  item.should_not be_nil
end
