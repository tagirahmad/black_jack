# frozen_string_literal: true

require_relative 'users/player'
require_relative 'users/dealer'
require_relative 'hand'
require_relative 'card/card'
require_relative 'card/card_deck'

class Game
  attr_reader :user, :bank, :card_deck, :deck, :winner, :computer

  def initialize
    @user = user
    @computer = computer
    @bank = 0
    @winner = nil
  end

  def initialize_players(player_name)
    @user = Player.new(player_name)
    @computer = Dealer.new
  end

  def make_first_steps
    @deck = CardDeck.new
    deal_cards(@user)
    deal_cards(@computer)
    make_bet
    count_players_score
  end

  def dealer_step
    if @computer.hand.cards.count < 3 && @computer.hand.score <= 17
      deal_cards(@computer, 1)
      puts 'Дилер взял карту, на руках 3 карты [*] [*] [*]'
    else
      puts 'Дилер пропустил ход'
    end
  end

  def add_card
    if @user.hand.cards.count < 3
      deal_cards(@user, 1)
    else
      puts 'Вы не можете взять больше карт'
    end
  end

  def judge
    count_players_score
    user_score = @user.hand.score
    computer_score = @computer.hand.score

    if user_score <= 21 && user_score > computer_score
      @winner = @user
    elsif computer_score <= 21 && computer_score > user_score
      @winner = @computer
    elsif user_score == computer_score && user_score <= 21
      @winner = 'everyone lost'
    elsif user_score == computer_score && user_score >= 21
      @winner = 'draw'
    end

    end_game
  end

  def end_game
    count_players_score
    distribute_money
    congratulations
    reset
  end

  def count_players_score
    @computer.hand.count_score
    @user.hand.count_score
  end

  private

  def deal_cards(player, quantity = 2)
    player.hand.cards << deck.card_deck.sample(quantity)
    player.hand.cards.flatten!
    deck.card_deck.delete_if { |card| player.hand.cards.include?(card) }
  end

  def make_bet
    @user.money -= 10
    @computer.money -= 10
    first_bit = 20
    @bank += first_bit
  end

  def distribute_money
    if @winner == @user
      @user.money += @bank
    elsif @winner == @computer
      @computer.money += @bank
    elsif @winner == 'draw'
      @user.money += (@bank / 2)
      @computer.money += (@bank / 2)
    end
  end

  def congratulations
    puts "Победитель: #{!@winner.is_a?(Player) ? @winner : @winner.name}\n"

    puts "Очки Дилера: #{@computer.hand.count_score}"
    puts "Очки игрока: #{@user.hand.count_score}"

    puts "\nДеньги Дилера: #{@computer.money} $"
    puts "Деньги игрока: #{@user.money} $"
  end

  def reset
    @user.hand = Hand.new
    @computer.hand = Hand.new
    @bank = 0
  end
end
