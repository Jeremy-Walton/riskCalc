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

  def calculate(win, die1, die2, position)
    # position (a or d) is not used yet
    if win
      @wins += 1
    else
      @losses += 1
    end

    luck_modifier = (die2.to_f / die1.to_f).round(2)
    update_values(win, luck_modifier, undo: false)
  end

  def calculate_undo(win, die1, die2, position)
    if win
      @wins -= 1
    else
      @losses-=1
    end

    luck_modifier = (die2.to_f / die1.to_f).round(2)
    update_values(win, -luck_modifier, undo: true)
  end

  def update_values(win, value, undo: false)
    if win
      @luckwins += value
    else
      @lucklosses += value
    end

    @ratio = @wins / @losses.to_f
    @luck = @luckwins / @lucklosses.to_f
  end
end
