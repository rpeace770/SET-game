class GamesController < ApplicationController

  def index
    @games = Game.order("sets DESC").limit(10)
  end

  def new
    @game = Game.new
  end

  def create

  end

  def show
    @game = Game.find(params[:id])
  end

end
