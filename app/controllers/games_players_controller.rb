class GamesPlayersController < ApplicationController
  before_filter :authenticate_user!

  # PUT /games_players/1
  # PUT /games_players/1.json
  def update
    @games_player = GamesPlayer.find(params[:id])
    orders_logger = OrdersLogger.new(@games_player)

    respond_to do |format|
      if @games_player.update_attributes(params[:games_player])

        orders_logger.compare_state @games_player

        format.html { redirect_to @games_player.game, notice: "Orders in game '#{@games_player.game.name}' updated."}
        format.json { head :no_content }  # TODO this can't be right

      else
        format.html { redirect_to_@games_player.game, notice: "Ooops!" }
        format.json { render json: @games_player.errors, status: :unprocessable_entity }
      end
    end
  end
end
