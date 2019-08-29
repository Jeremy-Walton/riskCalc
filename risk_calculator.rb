require 'random_name_generator'
require_relative 'player'

class RiskCalculator
  attr_accessor :game_over, :players

  def initialize
    @game_over = false
    @rolls = []
    @players = []
    @randomNames = []
    @log_messages = []
    @rng = RandomNameGenerator.new
  end

  def initialize_names(n)
    n.times { @randomNames.push(@rng.compose) }
  end

  def runScenario(player1_name, player2_name, die1, die2)
    @rolls.push([player1_name, player2_name, die1, die2])
    player1 = find_or_add_player(player1_name)
    player2 = find_or_add_player(player2_name)

    calculate(player1, player2, die1, die2)
    log_message(player1, player2, die1, die2)
  end

  def calculate(player1, player2, die1, die2)
    luck_modifier1 = (die2.to_f / die1.to_f).round(2)
    player1.update_values(true, luck_modifier1, false)

    luck_modifier2 = (die2.to_f / die1.to_f).round(2)
    player2.update_values(false, luck_modifier2, false)
  end

  def calculate_undo(player1, player2, die1, die2)
    luck_modifier1 = (die2.to_f / die1.to_f).round(2)
    player1.update_values(true, luck_modifier1, true)

    luck_modifier2 = (die2.to_f / die1.to_f).round(2)
    player2.update_values(false, luck_modifier2, true)
  end

  def undo_roll
    if !@rolls.empty?
      roll = @rolls.pop
      player1_name = roll[0]
      player2_name = roll[1]
      die1 = roll[2]
      die2 = roll[3]
      player1 = find_or_add_player(player1_name)
      player2 = find_or_add_player(player2_name)

      calculate_undo(player1, player2, die1, die2)
      log_message_undo(player1, player2, die1, die2)
    else
      puts 'No rolls yet'
      puts ''
    end
  end


  def log_message(player1, player2, num1, num2)
    @log_messages.push("#{player1.name} beat #{player2.name} in a #{num1} to #{num2} roll.")
  end

  def log_message_undo(player1, player2, num1, num2)
    if !@log_messages.empty?
      @log_messages.pop
    else
      puts "There are no messages to undo!"
    end
  end

  def logs
    @log_messages
  end

  def randomScenario(player_num, roll_num)
    @players = []
    @randomNames = []
    initialize_names(player_num.to_i)

    roll_num.times do
      player1 = find_or_add_player(@randomNames.sample)
      player2 = find_or_add_player(@randomNames.sample)
      calculate(player1, player2, rand(1..3), rand(1..3))
    end
  end

  def find_or_add_player(name)
    player = @players.find { |player| player.name == name }

    if !player || @players.empty?
      puts "New player (#{name}) added", ''
      player = Player.new(name)
      @players.push(player)
    end

    return player
  end

  def sort_players
    @players.sort_by(&:luck).reverse!
  end
end
