require_relative '../../models/player'
require_relative '../../models/roll'

RSpec.describe Roll, type: :model do
  let(:player1) { Player.new('Josh') }
  let(:player2) { Player.new('Jeremy') }
  let(:roll) { Roll.new(player1, player2, 1, 2) }

  describe 'create' do
    it 'has two players and two die numbers' do
      expect(roll.player1).to eq player1
      expect(roll.player2).to eq player2
      expect(roll.die1).to eq 1
      expect(roll.die2).to eq 2
    end
  end

  describe '#to_s' do
    it 'returns roll results as formatted string' do
      expect(roll.to_s).to eq "#{player1.name} beat #{player2.name} in a 1 to 2 roll."
    end
  end
end
