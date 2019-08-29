# Roll Model
class Roll
  attr_accessor :player1_name, :player2_name, :die1, :die2

  def initialize(player1_name, player2_name, die1, die2)
    @player1_name = player1_name
    @player2_name = player2_name
    @die1 = die1
    @die2 = die2
  end
end
