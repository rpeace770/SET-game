require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:deck) { Deck.new }

  describe "make deck" do
    it "should make a deck with 81 cards" do
      deck.send(:make_deck)
      expect(deck.cards.count).to eq(81)
    end
  end

  describe "draws cards" do
    before(:each) { deck.make_deck }

    it "will draw 3 cards" do
      blah = deck.draw_cards(3)
      expect(blah.count).to eq(3)
    end

    it "will draw 12 cards" do
      blah = deck.draw_cards(12)
      expect(blah.count).to eq(12)
    end
  end

end


