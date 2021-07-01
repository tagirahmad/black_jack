# frozen_string_literal: true

class CardDeck
  attr_reader :card_deck, :name

  def initialize
    @card_deck = []
    generate_card_deck
  end

  def generate_card_deck
    all_card_items = [(2..10).to_a, Card::LETTERS].flatten!
    all_card_items.each do |item|
      Card::SUITS.each do |suit|
        @card_deck << Card.new(suit, item)
      end
    end
  end
end
