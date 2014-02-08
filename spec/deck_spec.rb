require 'rspec'
require 'game'

describe Deck do

  subject(:deck) { Deck.new }

  it "starts with 52 cards" do
    expect(deck.cards.length).to eq(52)
  end

  it "doesn't have any card repeats" do
    expect(deck.cards.uniq.length).to eq(52)
  end

  describe "#draw" do

    it "takes one card off the top" do
      expect{ deck.draw }.to change(deck.cards, :length).by(-1)
    end

    it "returns a single card object" do
      expect(deck.draw.class).to eq(Card)
    end

    it "raises an error if you try to draw more cards than are left" do
      52.times { deck.draw }
      expect{ deck.draw }.to raise_error("Not enough cards left.")
    end
  end

  describe "#return" do

    it "puts a single card back on the bottom of the deck" do
      card = Card.new(:six, :diamonds)
      expect{ deck.return([card]) }.to change(deck.cards, :length).by(1)
      expect(deck.cards[0]).to eq(card)
    end

    it "puts multiple cards back on the bottom of the deck" do
      cards = [Card.new(:six, :diamonds), Card.new(:eight, :spades), Card.new(:ace, :clubs)]
      expect{ deck.return(cards)}.to change(deck.cards, :length).by(3)
    end

  end
end