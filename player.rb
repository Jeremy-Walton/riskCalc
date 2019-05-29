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

  def calculate(result, d1, d2, pos)
    if result == 'w'
      print @name + ' beat '
      @wins+=1
      if pos == 'a'
        if d1 == 3 && d2 == 1
          @luckwins += 0.33
        elsif d1 == 3 && d2 == 2
          @luckwins += 0.67
        elsif d1 == 2 && d2 == 1
          @luckwins += 0.5
        elsif d1 == 2 && d2 ==2
          @luckwins += 1
        elsif d1 == 1 && d2 == 1
          @luckwins += 1
        elsif d1 == 1 && d2 == 2
          @luckwins += 2
        end
      elsif pos == 'd'
        if d1 == 2 && d2 == 1
          @luckwins += 0.5
        elsif d1 == 2 && d2 == 2
          @luckwins += 1
        elsif d1 == 2 && d2 == 3
          @luckwins += 1.33
        elsif d1 == 1 && d2 ==1
          @luckwins += 1
        elsif d1 == 1 && d2 == 2
          @luckwins += 2
        elsif d1 == 1 && d2 == 3
          @luckwins += 1.67
        end
      end
    elsif result == 'l'
      puts @name + " in a #{d1} to #{d2} role. " + @name + random_message
      puts ''
      @losses += 1
      if pos == 'a'
        if d1 == 3 && d2 == 1
          @lucklosses += 0.33
        elsif d1 == 3 && d2 == 2
          @lucklosses += 0.67
        elsif d1 == 2 && d2 == 1
          @lucklosses += 0.5
        elsif d1 == 2 && d2 ==2
          @lucklosses += 1
        elsif d1 == 1 && d2 == 1
          @lucklosses += 1
        elsif d1 == 1 && d2 == 2
          @lucklosses += 2
        end
      elsif pos == 'd'
        if d1 == 2 && d2 == 1
          @lucklosses += 0.5
        elsif d1 == 2 && d2 == 2
          @lucklosses += 1
        elsif d1 == 2 && d2 == 3
          @lucklosses += 1.33
        elsif d1 == 1 && d2 ==1
          @lucklosses += 1
        elsif d1 == 1 && d2 == 2
          @lucklosses += 2
        elsif d1 == 1 && d2 == 3
          @lucklosses += 1.67
        end
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
