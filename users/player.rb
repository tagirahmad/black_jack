# frozen_string_literal: true

# Base class for player + human player model entity
class Player
  attr_reader :name
  attr_writer :money, :hand

  def initialize(name)
    @name = name
    @money = 100
    @hand = 0
  end
end
