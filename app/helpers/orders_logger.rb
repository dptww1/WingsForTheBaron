class OrdersLogger
  def initialize(games_player)
    @order1 = games_player.order1
    @order2 = games_player.order2
    @game = games_player.game
  end

  def compare_state(games_player)
    if games_player.order1 != @order1 || games_player.order2 != @order2
      @game.log("orders", games_player.side_name, games_player.order1, games_player.order2)
    end
  end
end
