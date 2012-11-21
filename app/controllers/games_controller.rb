class GamesController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  # GET /games/:id/do_war_status(.:format)
  def do_war_status
    @now = DateTime.now
    @game = Game.find(params[:id])

    # only game owner can do war status
    if @game.creator != current_user
      # TODO
    end

    card = @game.draw_war_status_card()
    @game.execute_war_status_card(card)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: "War Status Card #{card.card_num}: #{card.title}" }
        format.json { render json: @game.new_journal_items(@now).to_json(:methods => :event_text) }
      end
    end
  end

  # GET /games
  # GET /games.json
  def index
    @my_created_games       = []
    @my_participating_games = []
    @other_games            = Game.all

    if current_user
      @my_created_games = current_user.created
      @my_participating_games = Game.participating(current_user) - @my_created_games
      @other_games -= @my_created_games
      @other_games -= @my_participating_games
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(:name => params[:game][:name])

    @game.update_attributes(:creator => current_user)
    assign_players(@game)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if assign_players(@game)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

private
  def assign_players(game)
    Game.player_names.each do |pname|

      # If side is now unassigned....
      if params[:game]["#{pname.downcase}_email"].empty?
        p = game.find_player_by_side_name(pname)
        # ...but it used to exist, we need to delete it
        game.games_players.delete(p) if p

      else # side is now assigned
        user = User.where("email = ?", params[:game]["#{pname.downcase}_email"]).first()
        # TODO: user.nil?

        p = game.find_player_by_side_name(pname)

        # if side wasn't already assigned for this game, just add it
        if p.nil?
          game.games_players.build(:user => user, :side_name => pname)

        else # but if side /does/ already exist, substitute the new email address
          p.user = user
          p.save
        end
      end
    end

    true
  end
end
