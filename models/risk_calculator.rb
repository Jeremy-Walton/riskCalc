require 'random_name_generator'
require_relative 'player'
require_relative 'roll'

# Risk Calculator
class RiskCalculator
  attr_accessor :game_over, :players

  def initialize
    @game_over = false
    @rolls = []
    @players = []
    @random_names = []
    @log_messages = []
    @rng = RandomNameGenerator.new
  end

  def initialize_names(amount)
    amount.times { @random_names.push(@rng.compose) }
  end

  def run_scenario(player1_name, player2_name, die1, die2)
    player1 = find_or_add_player(player1_name)
    player2 = find_or_add_player(player2_name)

    new_roll = Roll.new(player1, player2, die1, die2)
    @rolls.push(new_roll)
    log_message(new_roll)

    calculate(player1, player2, die1, die2)
  end

  def calculate(player1, player2, die1, die2)
    luck = (die2.to_f / die1.to_f).round(2)

    player1.update_win(luck: luck)
    player2.update_loss(luck: luck)
  end

  def calculate_undo(player1, player2, die1, die2)
    luck = (die2.to_f / die1.to_f).round(2)

    player1.update_win(luck: luck, undo: true)
    player2.update_loss(luck: luck, undo: true)
  end

  def undo_roll
    if @rolls.any?
      roll = @rolls.pop

      calculate_undo(roll.player1, roll.player2, roll.die1, roll.die2)
      log_message_undo
    else
      puts "No rolls yet\n"
    end
  end

  def log_message(roll)
    @log_messages.push(roll.to_s)
  end

  def log_message_undo
    if !@log_messages.empty?
      @log_messages.pop
    else
      puts 'There are no messages to undo!'
    end
  end

  def logs
    @log_messages
  end

  def random_scenario(player_num, roll_num)
    @players = []
    @random_names = []
    initialize_names(player_num.to_i)

    roll_num.times do
      player1 = find_or_add_player(@random_names.sample)
      player2 = find_or_add_player(@random_names.sample)
      calculate(player1, player2, rand(1..3), rand(1..3))
    end
  end

  def find_or_add_player(name)
    player = @players.find { |p| p.name == name }

    if !player || @players.empty?
      puts "New player (#{name}) added", ''
      player = Player.new(name)
      @players.push(player)
    end

    player
  end

  def sort_players
    @players.sort_by(&:luck).reverse!
  end
end
