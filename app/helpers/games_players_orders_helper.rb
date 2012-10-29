module GamesPlayersOrdersHelper
  def current_orders_for_user(viewer, games_player)
    # TODO eventually, should decide whether to show actual orders
    # or not based on game phase (so everyone can see orders everyone
    # hash decided.
    orders = [games_player.order1, games_player.order2]

    # For other people's orders, just returns "true" if orders entered, "false" if not
    if games_player.user != viewer
      orders[0] != "None" && order[1] != "None"

    else # for your orders, returns your orders
      orders
    end
  end
end
