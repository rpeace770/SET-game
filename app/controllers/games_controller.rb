class GamesController < ApplicationController

  def index
    @games = Game.order("sets DESC").limit(10)
  end

  def new

    if session[:game_id]
      game = Game.find(session[:game_id])
      deck = game.deck

      cards_on_display = []
      session[:card_ids].each { |card_id| cards_on_display << Card.find(card_id) }
      @current_cards = cards_on_display
    else
      if current_user
        game = Game.new
        game.user = current_user
        game.save
      else
        freeloader = AnonymousUserHelper.anonymous
        game = Game.new
        game.user = freeloader
        game.save
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

    # possibly add error functionality

    # make a partial that uses each card in the cells table
    # use ajax to change the html on the new page
    # give the section an id that holds the list
    # give list items an id easier to identify
    # click events on specific list ids

    # end
    # @current_cards = session starts with 12 cards
    # user picks 3 cards (click events)
    # reset session as ajax always function

    # we need to get array of displayed_cards to pass to methods in deck
  end

  def create

    new_card_array = []

    new_card_array << Card.find(params[:array][0].to_i)
    new_card_array << Card.find(params[:array][1].to_i)
    new_card_array << Card.find(params[:array][2].to_i)

    result = deck.set_match?(new_card_array)
    if result == true
      new_cards = deck.draw_cards(3)
      # take the three positions and replace with draw card objects
      if request.xhr?
        # render partial show-card', card: new_cards[0] %>
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

  def twelve
    cards_on_display = []
    params[:card_ids].each { |card_id| cards_on_display << Card.find(card_id) }

    game = Game.find(session[:game_id])
    deck = game.deck

    # if deck.no_sets_left(cards_on_display)
      partials = []
      deck.draw_cards(3).each do |card|
        partials << render_to_string(partial: '/games/show-card', locals: { card: card })
      end
      render :json => { partials: partials }.to_json
    # else
    #   render :json => { message: "There are still sets. Look harder!" }.to_json
    # end
  end

  def fifteen
    cards_on_display = []
    params[:card_ids].each { |card_id| cards_on_display << Card.find(card_id) }

    game = Game.find(session[:game_id])
    deck = game.deck

    # if deck.no_sets_left(cards_on_display)
      partials = []
      blah = deck.replace_cards(cards_on_display)
      blah.each do |card|
        partials << render_to_string(partial: '/games/show-card', locals: { card: card })
      end
      render :json => { partials: partials }.to_json
    # else
    #  render :json => { message: "There are still sets. Look harder!" }.to_json
    # end
  end




  def show
    @game = Game.find(params[:id])
  end

end
