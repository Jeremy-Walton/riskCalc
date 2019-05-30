class Player
  attr_accessor :name, :ratio, :luck, :wins, :losses, :luckwins, :lucklosses
  def initialize(name)
    @name = name
    @luck = 0
    @luckwins = 0
    @lucklosses = 0
    @wins = 0
    @losses = 0
    @ratio = 0


  end

  def calculate(win, die1, die2, position, undo)
    # position (a or d) is not used yet
    if win
      print @name + ' beat ' # Should be moved to the calculator since the end of this sentance depends on the other player
      @wins += 1
    else
      puts @name + " in a #{die1} to #{die2} role. " + @name + random_message # Should be moved to the calculator since the end of this sentance depends on the other player
      puts ''
      @losses += 1 
    end 
    luck_modifier = (die2.to_f / die1.to_f).round(2)

    if win
      @luckwins += luck_modifier
    else
      @lucklosses += luck_modifier
    end

    @ratio = @wins / @losses.to_f
    @luck = @luckwins / @lucklosses.to_f
  end

  def calculate_undo(win, die1, die2, position)
    if win
      print "The roll where " + @name + ' beat '
      @wins -= 1
    else
      puts @name + " in a #{die1} to #{die2} role has been undone."
      puts ""
      @losses-=1
    end

    luck_modifier = (die2.to_f / die1.to_f).round(2)

    if win
      @luckwins -= luck_modifier
    else
      @lucklosses -= luck_modifier
    end

    @ratio = @wins / @losses.to_f
    @luck = @luckwins / @lucklosses.to_f
  end

  def random_message
    case rand(1..4)
    when 1; ' needs to quit sucking.'
    when 2; ' should get more luck.'
    when 3; ' should just give up at this point.'
    else; ' is the big unluck.'
    end
  end
end
