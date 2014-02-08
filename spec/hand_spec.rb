require 'rspec'
require 'game'

describe Hand do
  let(:deck) { Deck.new }
  subject(:hand)  { Hand.deal_from(deck) }
  let(:four_kind) { [Card.new(:four, :hearts), Card.new(:four, :spades), Card.new(:four, :diamonds), Card.new(:four, :clubs), Card.new(:five, :diamonds)]}
  let(:crap_hand) { [Card.new(:four, :hearts), Card.new(:nine, :spades), Card.new(:king, :diamonds), Card.new(:six, :clubs), Card.new(:five, :diamonds)]}
  let(:two_pair)  { [Card.new(:four, :hearts), Card.new(:four, :spades), Card.new(:queen, :diamonds), Card.new(:queen, :spades), Card.new(:six, :spades)]}
  let(:better_two_pair) { [Card.new(:king, :hearts), Card.new(:king, :spades), Card.new(:queen, :diamonds), Card.new(:queen, :spades), Card.new(:six, :spades)]}
  let(:better_four_kind) { [Card.new(:four, :hearts), Card.new(:four, :spades), Card.new(:four, :diamonds), Card.new(:four, :clubs), Card.new(:eight, :diamonds)]}

  it "starts with five cards" do
    expect(hand.cards.length).to eq(5)
  end

  it "shows itself as a string" do
    expect(hand.to_s).to be_a(String)
  end

  describe "#discard" do
    it "discards 3 specific cards" do
      hand.cards = crap_hand
      discard_cards = hand.cards.take(3)
      expect { hand.discard(discard_cards) }.to change(hand.cards, :length).by(-3)
    end
  end

  describe "#draw(n)" do
    it "draws 3 cards" do
      expect { hand.draw(3) }.to change(hand.cards, :length).by(3)
    end
  end

  describe "#best_hand" do
    it "finds a four-of-a-kind" do
      hand.cards = four_kind

      expect(hand.best_hand).to eq(:four)
    end

    it "finds a top-card" do
      hand.cards = crap_hand

      expect(hand.best_hand).to eq(:highcard)
    end

    it "finds a two-pair" do
      hand.cards = two_pair

      expect(hand.best_hand).to eq(:twopair)
    end
  end

  describe "#beats?(hand)" do

    let(:hand2) { Hand.deal_from(deck) }

    it "returns true when it beats the other hand" do
      hand2.cards = crap_hand
      hand.cards = four_kind

      expect(hand.beats?(hand2)).to be true
    end

    it "returns false when it doesn't beat the other hand" do
      hand2.cards = four_kind
      hand.cards = two_pair

      expect(hand.beats?(hand2)).to be false
    end

    context "goes to tiebreaker" do

      it "returns true when first hand wins" do
        hand.cards = better_two_pair
        hand2.cards = two_pair

        expect(hand.beats?(hand2)).to be true
      end

      it "returns false when first hand loses" do
        hand.cards = four_kind
        hand2.cards = better_four_kind

        expect(hand.beats?(hand2)).to be false
      end

    end

    it "returns false when the two are equal" do
      hand2.cards = two_pair
      hand.cards = two_pair

      expect(hand.beats?(hand2)).to be false
    end

  end

end
