class Dashboard::GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :set_form_path, only: [:new, :edit, :create, :update]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to edit_dashboard_game_path(@game), notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    if @game.update(game_params)
      redirect_to edit_dashboard_game_path(@game), notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    redirect_to dashboard_games_url, notice: 'Game was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.includes(:categories => :products).find(params[:id])
    end
    
    def set_form_path
      if params[:action] == 'new' || params[:action] == 'create'
        @form_path = dashboard_games_path
      else
        @form_path = dashboard_game_path  
      end 
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name, :created_at, :updated_at, :description, :permalink, :default_picture)
    end
end
