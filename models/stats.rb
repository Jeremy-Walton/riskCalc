require_relative 'player'
require_relative 'roll'

class Stats
attr_accessor :total_rolls, :wins, :losses, :luckwins, :lucklosses, :ratio,
    :luck, :streak_count, :streak, :one_one, :one_two, :two_two, :two_three, 
    :one_three, :three_to_one_losses, :t_one_one, :t_one_two, :t_two_two, 
    :t_two_three, :t_one_three

  def initialize()
    @total_rolls = 0
    @wins = 0
    @losses = 0
    @luckwins = 0
    @lucklosses = 0
    @ratio = 0
    @luck = 0
    @streak_count = 0
    @streak = 0
    @one_one = 0
    @one_two = 0
    @two_two = 0
    @two_three = 0
    @one_three = 0
    @t_one_one = 0
    @t_one_two = 0
    @t_two_two = 0
    @t_two_three = 0
    @t_one_three = 0
    @three_to_one_losses = 0
  end

  def update_winner(die1, die2)
    @total_rolls += 1

    if die1 == 1 && die2 == 1
      @one_one += 1
      @t_one_one += 1
    elsif die1 == 1 && die2 == 2
      @one_two += 1
      @t_one_two += 1
    elsif die1 == 1 && die2 == 3
      @one_three += 1
      @t_one_three += 1
    elsif die1 == 2 && die2 == 2
      @two_two += 1
      @t_two_two += 1
    elsif die1 == 2 && die2 == 3
      @two_three += 1
      @t_two_three += 1
    end
  end

  def update_loser(die1, die2)
    @total_rolls += 1

    if die1 == 1 && die2 == 1
      @t_one_one += 1
    elsif die1 == 1 && die2 == 2
      @t_one_two += 1
    elsif die1 == 1 && die2 == 3
      @t_one_three += 1
    elsif die1 == 2 && die2 == 2
      @t_two_two += 1
    elsif die1 == 2 && die2 == 3
      @t_two_three += 1
    end
  end

  def rolls_and_wins
    return ["Total Rolls", @total_rolls], ["Wins", @wins]
  end
end