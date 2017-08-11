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
          render :json => {thing: "You made a set!", ids: [new_cards[0].id, new_cards[1].id, new_cards[2].id], urls: [new_cards[0].url, new_cards[1].url, new_cards[2].url], sets_made: @game.sets}
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

    @game = Game.find(session[:game_id])
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
