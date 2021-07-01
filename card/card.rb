# frozen_string_literal: true

class Card
  attr_reader :name, :suit
  attr_accessor :score

  SUITS = %w[♠ ♥ ♣ ♦].freeze
  LETTERS = %i[J Q K A].freeze
  SCORES = { J: 10, Q: 10, K: 10, A: 11 }.freeze

  def initialize(suit, name)
    @suit = suit
    @name = name
  end

  def price
    @score = (2..10).include?(@name) ? @name : SCORES[@name]
  end

  def face
    "#{@suit} #{@name}"
  end
end
