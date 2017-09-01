module MakeDeckHelper

  def self.make_cards(deck)

    cards = []
    shapes = ["diamond", "oval", "squiggle"]
    colors = ["red", "green", "purple"]
    fills = ["empty", "striped", "solid"]
    numbers = ["1", "2", "3"]

    count = 0

    shapes.each do |shape|
      colors.each do |color|
        fills.each do |fill|
          numbers.each do |number|
            count += 1
            cards << Card.create(color: color, shape: shape, number: number, fill: fill, url: image_tag("card_" + count.to_s + ".png"), deck_id: deck.id)
          end
        end
      end
    end
  end


end
