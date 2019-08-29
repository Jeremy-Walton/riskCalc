# Roll Model
class Roll
  attr_accessor :player1, :player2, :die1, :die2

  def initialize(player1, player2, die1, die2)
    @player1 = player1
    @player2 = player2
    @die1 = die1
    @die2 = die2
  end

  def to_s
    "#{@player1.name} beat #{@player2.name} in a #{@die1} to #{@die2} roll."
  end
end
