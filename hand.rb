class Hand
  attr_accessor :score, :cards

  def initialize
    @cards = []
    @score = 0
  end

  def count_score
    sums_array ||= []
    @cards.each { |card| sums_array << card.price }
    sums_array[-1] = 1 if sums_array.last == 11 && sums_array.count(11) == 2
    sums_array[-1] = 1 if sums_array.last == 11 && sums_array[0..-2].sum > 10
    @score = sums_array.sum
  end
end