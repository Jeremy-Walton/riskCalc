class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)

    if @game.save
      flash[:success] = 'Game created'
      redirect_to games_path
    else
      respond_to do |format|
        format.js do
          render :new, content_type: 'text/html'
        end
      end
    end
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
