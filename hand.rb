# frozen_string_literal: true

class Hand
  attr_accessor :score, :cards

  def initialize
    @cards = []
    @score = 0
  end

  def count_score
    sums_array ||= []
    @cards.each { |card| sums_array << card.price }
    change_ace_score sums_array
    @score = sums_array.sum
  end

  private

  def change_ace_score(sums_arr)
    sums_arr[-1] = 1 if sums_arr.last == 11 && sums_arr.count(11) == 2
  end
end
