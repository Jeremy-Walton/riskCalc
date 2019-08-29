# Player Model
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

  def update_win(luck:, undo: false)
    win_value = undo ? -1 : 1
    luck_value = undo ? -luck : luck

    @wins += win_value
    @luckwins += luck_value
    update_ratios
  end

  def update_loss(luck:, undo: false)
    loss_value = undo ? -1 : 1
    luck_value = undo ? -luck : luck

    @losses += loss_value
    @lucklosses += luck_value
    update_ratios
  end

  def update_ratios
    @ratio = @wins / @losses.to_f
    @luck = @luckwins / @lucklosses.to_f
  end
end
