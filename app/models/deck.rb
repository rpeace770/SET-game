class Deck < ApplicationRecord

  belongs_to :game, dependent: :destroy
  has_many :cards

  def draw_cards(number)
    shuffled_cards = self.cards.to_a.shuffle!
    shuffled = shuffled_cards.slice!(0, number)
    delete_cards(shuffled)
    return shuffled
  end

  def delete_cards(card_array)
    self.cards -= card_array
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

  def finished?(displayed_cards)
    return true if no_sets_left(displayed_cards) && self.cards.length < 3
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

  def replace_cards(displayed_cards)
    displayed_cards.pop(3)
    displayed_cards << draw_cards(3)
  end

end


