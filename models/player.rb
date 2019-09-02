require_relative 'stats'
# Player Model
class Player
  attr_accessor :name, :luck_v_time, :stats

  def initialize(name)
    @name = name
    @luck_v_time = []
    @stats = Stats.new()
  end

  def update_win(luck:, undo: false)
    win_value = undo ? -1 : 1
    luck_value = undo ? -luck : luck

    @stats.wins += win_value
    @stats.luckwins += luck_value
    update_ratios(undo: undo)
  end

  def update_loss(luck:, undo: false)
    loss_value = undo ? -1 : 1
    luck_value = undo ? -@stats.luck : @stats.luck

    @stats.losses += loss_value
    @stats.lucklosses += luck_value
    update_ratios(undo: undo)
  end

  def update_ratios(undo: false)
    @stats.ratio = (@stats.losses.zero? ? @stats.wins.to_f : @stats.wins.to_f / @stats.losses.to_f).round(2)
    @stats.luck = (@stats.lucklosses.zero? ? @stats.luckwins.to_f : @stats.luckwins.to_f / @stats.lucklosses.to_f).round(2)

    undo ? @luck_v_time.pop() : @luck_v_time.push([@luck_v_time.length + 1, @stats.luck])
  end
end
