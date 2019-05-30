class RiskCalculator
  attr_accessor :game_over

  def initialize
    @game_over = false
    @rolls = []
    @players = []
  end

  def print_welcome_message
    puts "
      Hello, Welcome to your Risk luck calculator! To input a dice role,
      simply type the two names of the players in the order winner loser
      followed by the dice ratio followed by either 'd' or 'a' to signify
      if the winner was attacking or defending.

      Here is an example: ben josh 3 1 a

      P.S. Don't input ties!
    "
    help
  end

  def help
    puts "
      To view this list of available commands again, type 'help'
      To view the current list of players and their luckiness, type 'list'
      To view a list of past rolls, type 'rolls'
      To undo a roll, type 'undo'
      To exit script, type 'game over'
    "
  end

  def end_game
    @game_over = true
    puts 'Thanks for playing!'
  end

  def list_players
    divider = '-----------------------------------Players-------------------------------------'

    if @players.empty?
      puts 'The list is empty', ''
    else
      puts divider
      format = '%-15s %-10s %-10s %-10s %-10s %-10s %-10s'
      puts format % ['Player', 'Wins', 'Losses', 'AdjW', 'AdjL', 'Ratio', 'AdjR']

      @players.each do |p|
        puts format % [p.name, p.wins, p.losses, p.luckwins, p.lucklosses, p.ratio.round(2), p.luck.round(2)]
      end
      puts divider
      puts ''
    end
  end

  def display_rolls
    return puts 'No rolls yet', '' if @rolls.empty?

    divider = '------------------Rolls-------------------'
    puts divider
    puts @rolls
    puts divider
    puts ''
  end
 
  def undo_roll
    if !@rolls.empty?
      inputString = @rolls.pop().split(' ')
      player1 = find_or_add_player(inputString[0])
      player2 = find_or_add_player(inputString[1])

      player1.calculate_undo(true, inputString[2].to_i, inputString[3].to_i, inputString[4])
      player2.calculate_undo(false, inputString[2].to_i, inputString[3].to_i, inputString[4])

    else 
      puts "No rolls yet" 
      puts ""
    end 
  end

  def runScenario(rawInput)
    inputString = rawInput.split(' ')
    if inputString.size() != 4  || inputString[2].to_i > 3 || inputString[3].to_i > 3
      puts "Invalid input! Try again"
      puts ""
    else
      @rolls.push(rawInput)
      player1 = find_or_add_player(inputString[0])
      player2 = find_or_add_player(inputString[1])

      player1.calculate(true, inputString[2].to_i, inputString[3].to_i, inputString[4])
      player2.calculate(false, inputString[2].to_i, inputString[3].to_i, inputString[4])
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
end
