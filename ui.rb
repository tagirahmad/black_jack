# frozen_string_literal: true

require_relative 'game'

class GameInterface
  def initialize
    puts 'Добро пожаловать в игру Black Jack!'
    @game = Game.new
  end

  def ask_name
    puts 'Укажите свое имя: '
    @game.initialize_players(gets.chomp)
  end

  def first_steps
    puts "Деньги Дилера: #{@game.computer.money} $"
    puts "Деньги игрока: #{@game.user.money} $"
    @game.make_first_steps
    puts "Вам раздали карты, на руках #{@game.user.hand.cards.map(&:face)}"
    puts "У вас #{@game.user.hand.score}"
    puts 'У дилера на руках 2 карты [*] [*]'
    player_turn
  end

  def player_turn
    puts 'Ваш ход: 1 - Пропустить ход  2 - Взять карту  3 - Открыть карты'
    choice = gets.chomp
    case choice
    when '1' then skip_turn
    when '2' then take_card
    when '3' then show_players_cards
    else
      puts 'Неправильный ход'
      player_turn
    end
  end

  def skip_turn
    puts 'Вы пропустили ход'
    @game.dealer_step
    compare_scores
  end

  def take_card
    @game.add_card
    puts 'Вы взяли карту'
    @game.dealer_step
    check_if_scores_equal
  end

  def show_players_cards
    show_cards(@game.computer)
    show_cards(@game.user)
    @game.judge
    play_again
  end

  def show_cards(player)
    @game.count_players_score
    puts "#{player.name}\n\nОчки: #{player.hand.score}. \nКарты: #{player.hand.cards.map(&:face)}\n\n"
  end

  def play_again
    puts "\nХотите сыграть еще раз? 1. Да. 2. Нет."
    choice = gets.chomp
    case choice
    when '1' then first_steps
    when '2' then exit
    else
      puts 'Неправильная команда'
      play_again
    end
  end

  private

  def check_if_scores_equal
    if @game.computer.hand.cards.count == 3 && @game.user.hand.cards.count == 3
      show_cards(@game.computer)
      show_cards(@game.user)
      @game.judge
      play_again
    else
      player_turn
    end
  end

  def compare_scores
    if @game.computer.hand.cards.count != @game.user.hand.cards.count || @game.computer.hand.cards.count < 3
      player_turn
    elsif @game.computer.hand.cards.count == 3 && @game.user.hand.cards.count == @game.computer.hand.cards.count
      show_cards(@game.computer)
      show_cards(@game.user)
      @game.judge
      play_again
    else
      player_turn
    end
  end
end
