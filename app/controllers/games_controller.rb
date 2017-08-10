class GamesController < ApplicationController

  def index
    @games = Game.order("sets DESC").limit(10)
  end

  def new
    # if no user has logged in, then we need to create an anonymous account so that a game can be created
    # if !current_user
    #   random_user = AnonymousUserHelper.anonymous
    #   session[:user_id] = random_user.id
    # end
    # no access to deck

    if session[:game_id]
      binding.pry
      @game = Game.find(session[:game_id])
    else
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
    end
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

    if request.xhr?
      render json: { thing: result.to_s }
    else
      "poop"
    end
  end

  def checker
    binding.pry
    if @deck.no_sets_left(@current_cards)
      if @current_cards.length == 12
        @deck.draw_cards(3)
      elsif @current_cards.length == 15
        @deck.replace_cards(@current_cards)
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
