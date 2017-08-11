class GamesController < ApplicationController

  def index
    @games = Game.order("sets DESC").limit(10)
  end

  def new
    #binding.pry
    if session[:game_id]
      # want to redisplay current cards on board

      game = Game.find(session[:game_id])
      deck = game.deck

      cards_on_display = []
      session[:card_ids].each { |card_id| cards_on_display << Card.find(card_id) }
      @current_cards = cards_on_display

      # @current_cards = deck.cards
      # this needs work
      # printing bigger board
    else
      if current_user
        game = Game.new
        game.user = current_user
        game.save
        session[:user_id] = current_user.id
      else
        freeloader = AnonymousUserHelper.anonymous
        game = Game.new
        game.user = freeloader
        game.save
        session[:user_id] = freeloader.id
      end
    session[:game_id] = game.id
    deck = Deck.new
    deck.game = game
    deck.save

      MakeDeckHelper.make_cards(deck)
      @current_cards = deck.draw_cards(12)

      current_card_ids = []
      @current_cards.each do |card|
        current_card_ids << card.id
      end
      session[:card_ids] = current_card_ids
    end
  end

  def create
    @game = Game.find(session[:game_id])
    cards_on_display = []
      session[:card_ids].each { |card_id| cards_on_display << Card.find(card_id) }
      @current_cards = cards_on_display
    if @game.deck.finished?(@current_cards)
      @game.end_time = Time.now
      session[:game_id] = nil
      redirect_to game_path(@game)
    else
      new_card_array = []
      new_card_array << Card.find(params[:array][0].to_i)
      new_card_array << Card.find(params[:array][1].to_i)
      new_card_array << Card.find(params[:array][2].to_i)
      result = @game.deck.set_match?(new_card_array)
      if result == true
        new_cards = @game.deck.draw_cards(3)
        @game.sets += 1
        @game.save
        if request.xhr?
          render :json => {thing: "You made a set!", ids: [new_cards[0].id, new_cards[1].id, new_cards[2].id], urls: [new_cards[0].url, new_cards[1].url, new_cards[2].url]}
        else
          redirect_to 'games/new'
        end
      else
        if request.xhr?
          render json: {
            error: "FUCK"
            }, status: :not_found
        else
          redirect_to 'games/new'
        end
      end
    end
  end

  def checker
    # from ajax, get card ids and find Card
    cards_on_display = []
    params[:card_ids].each { |card_id| cards_on_display << Card.find(card_id) }

    @game = Game.find(session[:game_id])
    deck = game.deck
    if deck.no_sets_left(cards_on_display)
      if cards_on_display.length == 12
        deck.draw_cards(3)
      elsif cards_on_display.length == 15
        deck.replace_cards(cards_on_display)
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
