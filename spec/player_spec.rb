require 'rspec'
require 'game'

describe Player do
  let(:deck) { Deck.new }
  subject(:player) { Player.new(Hand.draw_from(deck), 2000) }

  it "has a hand" do
    expect(player.hand).to be_truthy
  end

  it "has a pot" do
    expect(player.pot).to eq(2000)
  end

  describe "#bet" do
    it "reduces player pot by bet amt" do
      expect { player.bet(200) }.to change(player, :pot).by(-200)
    end
  end
end