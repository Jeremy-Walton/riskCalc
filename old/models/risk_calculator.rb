require 'random_name_generator'
require_relative 'player'
require_relative 'roll'

# Risk Calculator
class RiskCalculator
  attr_accessor :players, :streak_holder, :rolls

  def initialize
    @rolls = []
    @players = []
    @random_names = []
    @log_messages = []
    @rng = RandomNameGenerator.new
  end

  def initialize_names(amount)
    amount.times { @random_names.push(@rng.compose) }
  end

  def load_game(arr)
    arr.each do |line|
      line = line[0].split(",")
      run_scenario(line[0].to_s, line[1].to_s, line[2].to_i, line[3].to_i)
    end
  end

  def run_scenario(player1_name, player2_name, die1, die2)
    player1 = find_or_add_player(player1_name)
    streak(player1)
    player2 = find_or_add_player(player2_name)

    new_roll = Roll.new(player1, player2, die1, die2)
    @rolls.push(new_roll)

    log_message(new_roll)
    calculate(new_roll)
  end

  def calculate(roll)
    roll.player1.update_win(luck: roll.luck)
    roll.player2.update_loss(luck: roll.luck)
  end

  def calculate_undo(roll)
    roll.player1.update_win(luck: roll.luck, undo: true)
    roll.player2.update_loss(luck: roll.luck, undo: true)
  end

  def undo_roll
    if @rolls.any?
      roll = @rolls.pop

      calculate_undo(roll)
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

    while roll_num > 0
      player1 = find_or_add_player(@random_names.sample)
      player2 = find_or_add_player(@random_names.sample)
      if player1.name != player2.name
        run_scenario(player1.name, player2.name, rand(1..3), rand(1..3))
        roll_num -= 1
      end
    end
  end

  def streak(player)
    if @streak_holder == player.name
      player.streak_count += 1
      if player.streak_count >= player.streak
        player.streak = player.streak_count + 1
      end
    else
      player.streak_count = 0
    end
    @streak_holder = player.name
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

  def clear
    @players = []
    @rolls = []
    @log_messages = []
  end

  # Chart Metrics
  def one_to_three_wins(player)
    @rolls.select { |roll| roll.player1 == player && roll.die1 == 1 && roll.die2 == 3 }.count
  end

  def three_to_one_losses(player)
    @rolls.select { |roll| roll.player2 == player && roll.die1 == 1 && roll.die2 == 3 }.count
  end
end
