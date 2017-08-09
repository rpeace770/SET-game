class Deck

  attr_accessor :cards

  def initialize
    @cards = []
  end

  def make_deck
    colors = ["red", "green", "purple"]
    fills = ["empty", "solid", "striped"]
    numbers = ["1", "2", "3"]
    shapes = ["oval", "squiggle", "diamond"]

    colors.each do |color|
      fills.each do |fill|
        numbers.each do |number|
          shapes.each do |shape|
            @cards << Card.new(color, shape, number, fill)
          end
        end
      end
    end
  end

  def draw_cards(number)
    @cards.shuffle!
    return @cards.slice!(0, number)
  end

  def set_match?(array)
    numbers = []
    fills = []
    shapes = []
    colors = []

    array.each do |card|
      numbers << card.number
      fills << card.fill
      shapes << card.shape
      colors << card.color
    end

    return false if check_stuff(numbers) == false
    return false if check_stuff(fills) == false
    return false if check_stuff(shapes) == false
    return false if check_stuff(colors) == false
    return true

  end

  def check_stuff(array)
    new_array = array.uniq
    return false if new_array.length == 2
  end

  def finished?
    return true if no_sets_left && self.cards.length < 3
  end

  def no_sets_left(displayed_cards)
    no_sets = true
    displayed_cards.combination(3).to_a.each do |thrice|
      if set_match?(thrice)
        no_sets  = false
        break
      end
    end
    no_sets
  end

  # user click button thinking there are no more sets
  # if there are no more sets, like the user thinks, then we need to add 3 more cards if there are 12
    # but if there are 15 cards on screen, we need to remove 3 and add 3 more (if there are cards left in deck to put out)
  # else (if there are sets), we need to alert user to look harder


  # remove cards if there are 15 currently present
  # def placeholder(displayed_cards)
  #   if displayed_cards.length == 15
  #     displayed_cards.
  # end
  # accomplished with pop, do not need this method
  # but maybe we do...


  # when the button is pushed
    # call no_set_left method
        # if true
          displayed_cards.pop(3)
          displayed_cards << draw_cards(3)
      # else
        # you're stupid
      # end



end

deck = Deck.new
deck.make_deck
x = deck.draw_cards(12)
y = deck.no_sets_left(x)
binding.pry

