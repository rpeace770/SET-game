class GamesController < ApplicationController

  def index
    @games = Game.order("sets DESC").limit(10)
  end

  def new

    # if session[:game_id]
    #   binding.pry
    #   @game = Game.find(session[:game_id])
    #   # no access to deck, when will we get routed here?
    # else
      if current_user
        @game = Game.create!(:user_id => current_user.id )
      else
        freeloader = AnonymousUserHelper.anonymous
        @game = Game.create!(:user_id => freeloader.id)
      end

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
    # end
    # @current_cards = session starts with 12 cards
    # user picks 3 cards (click events)
    # reset session as ajax always function

    # we need to get array of displayed_cards to pass to methods in deck
  end

  def create
    new_card_array = []

    new_card_array << Card.find(params[:array][0])
    new_card_array << Card.find(params[:array][1])
    new_card_array << Card.find(params[:array][2])

    result = deck.set_match?(new_card_array)
    if result == true
      # replace cards that made set by throwing new partial at screen with new cards
      if request.xhr?
        # render '_show-card'
      else
        redirect_to 'games/new'
      end
    else
      # alert that it was not a set
    end
  end

  def checker
    # from ajax, get card ids and find Card
    if deck.no_sets_left(@current_cards)
      if @current_cards.length == 12
        deck.draw_cards(3)
      elsif @current_cards.length == 15
        deck.replace_cards(@current_cards)
      else
        puts "Something is wrong."
      end
    else # if there are sets available
      "YOU'RE STUPID"
    end
  end

  def show
    @game = Game.find(params[:id])
  end

end
