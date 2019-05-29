class Player
  attr_accessor :name, :ratio, :luck, :roles, :wins, :losses, :luckwins, :lucklosses
  def initialize(name)
    @name = name
    @luck = 0
    @luckwins = 0
    @lucklosses = 0
    @roles = 0
    @wins =  0
    @losses = 0
    @ratio = 0
  end

  def calculate(win, die1, die2, position)
    if win
      print @name + ' beat ' # Should be moved to the calculator since the end of this sentance depends on the other player
      @wins += 1
    else
      puts @name + " in a #{die1} to #{die2} role. " + @name + random_message # Should be moved to the calculator since the end of this sentance depends on the other player
      puts ''
      @losses += 1
    end

    luck_attribute = win ? @luckwins : @lucklosses
    if position == 'a'
      if die1 == 3 && die2 == 1
        luck_attribute += 0.33
      elsif die1 == 3 && die2 == 2
        luck_attribute += 0.67
      elsif die1 == 2 && die2 == 1
        luck_attribute += 0.5
      elsif die1 == 2 && die2 ==2
        luck_attribute += 1
      elsif die1 == 1 && die2 == 1
        luck_attribute += 1
      elsif die1 == 1 && die2 == 2
        luck_attribute += 2
      end
    else
      if die1 == 2 && die2 == 1
        luck_attribute += 0.5
      elsif die1 == 2 && die2 == 2
        luck_attribute += 1
      elsif die1 == 2 && die2 == 3
        luck_attribute += 1.33
      elsif die1 == 1 && die2 ==1
        luck_attribute += 1
      elsif die1 == 1 && die2 == 2
        luck_attribute += 2
      elsif die1 == 1 && die2 == 3
        luck_attribute += 1.67
      end
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
