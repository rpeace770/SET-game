class Card

  attr_reader :color, :shape, :number, :fill

  def initialize(color, shape, number, fill)
    @color = color
    @shape = shape
    @number = number
    @fill = fill
  end

end
