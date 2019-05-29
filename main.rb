require_relative 'player'
require_relative 'risk_calculator'

riskCalc = RiskCalculator.new

riskCalc.print_welcome_message

while !riskCalc.game_over do
  string = gets.chomp
  puts ''

  case string.downcase
  when 'help'; riskCalc.help
  when 'list'; riskCalc.list_players
  when 'rolls'; riskCalc.display_rolls
  when 'game over'; riskCalc.end_game
  else;riskCalc.runScenario(string)
  end
end
