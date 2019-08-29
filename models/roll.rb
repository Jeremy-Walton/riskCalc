# Roll Model
class Roll
  attr_accessor :player1, :player2, :die1, :die2

  def initialize(player1, player2, die1, die2)
    @player1 = player1
    @player2 = player2
    @die1 = die1
    @die2 = die2
  end
end
