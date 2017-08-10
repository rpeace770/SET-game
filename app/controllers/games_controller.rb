class GamesController < ApplicationController

  def index
    @games = Game.order("sets DESC").limit(10)
  end

  def new
    if session[:game_id]
      @game = Game.find(session[:game_id])
    else
      @game = Game.new
      session[:game_id] = @game.id
      deck = Deck.new
      deck.make_deck
      @current_cards = deck.draw_cards(12)

      # possibly add error functionality

      # make a partial that uses each card in the cells table
      # use ajax to change the html on the new page
      # give the section an id that holds the list
      # give list items an id easier to identify
      # click events on specific list ids
      #
    end
    # @current_cards = session starts with 12 cards
    # user picks 3 cards (click events)
    # reset session as ajax always function

    # we need to get array of displayed_cards to pass to methods in deck
  end

  def create
    # respond_to do |format|
    #   format.js
    # end
    if request.xhr?
      render json: { thing: "pooper" }
    else
      "poop"
    end
  end

  def show
    @game = Game.find(params[:id])
  end

end
