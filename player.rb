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

  def update_values(win, value, undo)
    if undo
      if win
        @wins -=1
        @luckwins -= value
      else
        @losses -=1
        @lucklosses -= value
      end
    else
      if win
        @wins +=1
        @luckwins += value
      else
        @losses +=1
        @lucklosses += value
      end
    end

    @ratio = @wins / @losses.to_f
    @luck = @luckwins / @lucklosses.to_f
  end
end
