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

  def rolls
   @rolls
  end

  def undo_roll
    if !@rolls.empty?
      inputString = @rolls.pop().split(' ')
      player1 = find_or_add_player(inputString[0])
      player2 = find_or_add_player(inputString[1])

      player1.calculate_undo(true, inputString[2].to_i, inputString[3].to_i, inputString[4])
      player2.calculate_undo(false, inputString[2].to_i, inputString[3].to_i, inputString[4])
      log_message_undo(player1, player2, inputString[2].to_i, inputString[3].to_i)
     else
      puts 'No rolls yet'
      puts ''
    end
  end

  def runScenario(rawInput)
    inputString = rawInput.split(' ')
    if inputString.size() != 4  || inputString[2].to_i > 3 || inputString[3].to_i > 3
      puts 'Invalid input! Try again'
      puts ''
    else
      @rolls.push(rawInput)
      player1 = find_or_add_player(inputString[0])
      player2 = find_or_add_player(inputString[1])

      player1.calculate(true, inputString[2].to_i, inputString[3].to_i, inputString[4])
      player2.calculate(false, inputString[2].to_i, inputString[3].to_i, inputString[4])
      log_message(player1, player2, inputString[2].to_i, inputString[3].to_i )
    end
  end

  def log_message(player1, player2, num1, num2)
    @log_messages.push("#{player1.name} beat #{player2.name} in a #{num1} to #{num2} roll.")
  end

  def log_message_undo(player1, player2, num1, num2)
    @log_messages.pop
  end

  def log
    @log_messages
  end

  def randomScenario(player_num, roll_num)
    @players = []
    @randomNames = []
    initialize_names(player_num.to_i)
    
    roll_num.times do
      player1 = find_or_add_player(@randomNames.sample)
      player2 = find_or_add_player(@randomNames.sample)
      player1.calculate(true, rand(1..3), rand(1..3), 'd')
      player2.calculate(false, rand(1..3), rand(1..3), 'd')
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
