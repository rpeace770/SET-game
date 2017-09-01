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
      # add current set number
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
      if request.xhr?
        # render :json => { partial: "_show-whole" }
        render :json => { :attachmentPartial => render_to_string('_show-whole', :layout => false, :locals => { :game => @game }) }
        # render partial: "_show-whole", locals: { game: @game }
      else
        redirect_to game_path(@game)
      end
    else
      new_card_array = []
      new_card_array << Card.find(params[:array][0].to_i)
      new_card_array << Card.find(params[:array][1].to_i)
      new_card_array << Card.find(params[:array][2].to_i)
      result = @game.deck.set_match?(new_card_array)

      if result == true && @current_cards.length == 12 && @game.deck.cards.count > 0
        new_cards = @game.deck.draw_cards(3)
        @game.sets += 1
        @game.save
        if request.xhr?
          render :json => {thing: "You made a set!", ids: [new_cards[0].id, new_cards[1].id, new_cards[2].id], urls: [new_cards[0].url, new_cards[1].url, new_cards[2].url], sets_made: @game.sets}
        else
          redirect_to 'games/new'
        end
      elsif result == true && @current_cards.length == 15
        session[:card_ids] -= params[:array]
        @game.deck.delete_cards(new_card_array)
        if request.xhr?
          render :json => {thing: "You made a set!", sets_made: @game.sets}
        else
          redirect_to 'game/new'
        end
      elsif result == true && @current_cards.length <= 12 && @game.deck.cards.count == 0
        session[:card_ids] -= params[:array]
        @game.sets += 1
        @game.save
        if request.xhr?
          render :json => {thing: "You made a set!", sets_made: @game.sets}
        else
          redirect_to 'games/new'
        end
      else
        if request.xhr?
          render json: {
            error: "AAAHHH"
            }, status: :not_found
        else
          redirect_to 'games/new'
        end
      end
    end
  end


  def twelve
    cards_on_display = []
    # cards_on_display_ids = []
    params[:card_ids].each { |card_id| cards_on_display << Card.find(card_id) }

    game = Game.find(session[:game_id])
    deck = game.deck

    if deck.no_sets_left(cards_on_display)
      partials = []
      deck.draw_cards(3).each do |card|
        partials << render_to_string(partial: '/games/show-card', locals: { card: card })
        session[:card_ids] << card.id
        # will we have more than 12 card ids in here?
      end
      render :json => { partials: partials }.to_json
    else
      render :json => { message: "There are still sets. Look harder!" }.to_json
    end
  end


  def fifteen
    cards_on_display = []
    cards_on_display_ids = []
    params[:card_ids].each { |card_id| cards_on_display << Card.find(card_id) }

    game = Game.find(session[:game_id])
    deck = game.deck

    if deck.no_sets_left(cards_on_display)
      partials = []
      blah = deck.replace_cards(cards_on_display)
      blah.each do |card|
        partials << render_to_string(partial: ' /games/show-card', locals: { card: card })
        cards_on_display_ids << card_id
      end
      session[:card_ids] = cards_on_display_ids
      render :json => { partials: partials }.to_json
    else
     render :json => { message: "There are still sets. Look harder!" }.to_json
    end
  end

  def nine
    cards_on_display = []
    cards_on_display_ids = []
    params[:card_ids].each { |card_id| cards_on_display << Card.find(card_id) }

    game = Game.find(session[:game_id])
    deck = game.deck

    if deck.no_sets_left(cards_on_display)
      render :json => { :attachmentPartial => render_to_string('_show-whole', :layout => false, :locals => { :game => game }) }
    else
     render :json => { message: "There are still sets. Look harder!" }.to_json
    end
  end


  def show
    @game = Game.find(params[:id])
  end

end
