require_relative '../../models/player'

RSpec.describe Player, type: :model do
  subject(:player) { Player.new('Jeremy') }

  describe 'create' do
    it 'initializes with' do
      expect(player.name).to eq 'Jeremy'
      expect(player.lucklosses).to eq 0
      expect(player.luckwins).to eq 0
      expect(player.losses).to eq 0
      expect(player.ratio).to eq 0
      expect(player.luck).to eq 0
      expect(player.wins).to eq 0
    end
  end

  describe '#update_win' do
    it 'increments wins and luckwins' do
      luck = 10

      expect { player.update_win(luck: luck) }.to change(player, :wins).from(0).to(1).
        and change(player, :luckwins).from(0).to(luck)
    end

    it 'undo decrements wins and luckwins' do
      luck = 10

      expect { player.update_win(luck: luck, undo: true) }.to change(player, :wins).from(0).to(-1).
        and change(player, :luckwins).from(0).to(-luck)
    end
  end

  describe '#update_loss' do
    it 'increments losses and lucklosses' do
      luck = 10

      expect { player.update_loss(luck: luck) }.to change(player, :losses).from(0).to(1).
        and change(player, :lucklosses).from(0).to(luck)
    end

    it 'undo decrements wins and luckwins' do
      luck = 10

      expect { player.update_loss(luck: luck, undo: true) }.to change(player, :losses).from(0).to(-1).
        and change(player, :lucklosses).from(0).to(-luck)
    end
  end

  describe '#update_ratios' do
    it 'Updates the ratio properly' do
      player.wins = 1
      player.losses = 2
      player.luckwins = 4
      player.lucklosses = 3

      player.update_ratios
      expect(player.ratio).to eq 0.5
      expect(player.luck).to eq 1.33
    end

    it 'handles dividing by zero' do
      player.wins = 2
      player.losses = 0
      player.luckwins = 4
      player.lucklosses = 0

      player.update_ratios
      expect(player.ratio).to eq 2
      expect(player.luck).to eq 4
    end

    it 'handles dividing zero' do
      player.wins = 0
      player.losses = 2
      player.luckwins = 0
      player.lucklosses = 1

      player.update_ratios
      expect(player.ratio).to eq 0
      expect(player.luck).to eq 0
    end
  end
end
