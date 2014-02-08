class Hand

  HAND_RANKS = {
    sflush: 1,
    four: 2,
    fhouse: 3,
    flush: 4,
    straight: 5,
    three: 6,
    twopair: 7,
    two: 8,
    highcard: 9
  }

  attr_accessor :cards
  attr_reader :deck

  def self.deal_from(deck)
    cards = []
    5.times { cards << deck.draw }
    Hand.new(cards, deck)
  end

  def initialize(cards, deck)
    @cards = cards
    @deck = deck
  end

  def discard(discards)
    @deck.return(discards)
    discards.each do |discard|
      value, suit = discard.value, discard.suit
      @cards.delete_if do |card|
        card.value == value && card.suit == suit
      end
    end
  end

  def draw(n)
    n.times { self.cards << self.deck.draw }
  end

  def to_s
    self.cards.join(' ')
  end

  def beats?(their_hand)
    our_rank, their_rank = HAND_RANKS[self.best_hand], HAND_RANKS[their_hand.best_hand]

    if our_rank != their_rank
      our_rank < their_rank
    else
      self.tie_breaker(their_hand)
    end
  end

  def best_hand
    case true
    when straight? && flush?
      :sflush
    when sets.first[1] == 4
      :four
    when sets[0][1] == 3 && sets[1][1] == 2
      :fhouse
    when flush?
      :flush
    when straight?
      :straight
    when sets[0][1] == 3
      :three
    when sets[0][1] == 2 && sets[1][1] == 2
      :twopair
    when sets[0][1] == 2
      :two
    else
      :highcard
    end
  end

  protected

    def tie_breaker(their_hand)
      our_sets, their_sets = self.sets, their_hand.sets

      our_sets.each_with_index do |set, index|
        return true if set[0] > their_sets[index][0]
        return false if set[0] < their_sets[index][0]
      end
      false
    end

    def straight?
      sequence = self.cards.map {|card| card.worth }.sort
      low_card = sequence[0]

      return true if sequence == (low_card..low_card + 4).to_a

      if sequence.include?(14)
        sequence2 = sequence.map{ |worth| worth == 14 ? 1 : worth }.sort
        return true if sequence2 == (1..5).to_a
      end

      false
    end

    def flush?
      suits = self.cards.map{|card| card.suit }

      suits.uniq.length == 1
    end

    def sets
      prc = Proc.new do |x, y|
        if x[1] == y[1]
          y[0] <=> x[0]
        else
          y[1] <=> x[1]
        end
      end

      sets = Hash.new(0)
      self.cards.each do |card|
        sets[card.worth] += 1
      end

      sets.to_a.sort(&prc)
    end

    def high_card(cards)
      cards.map { |card| card.worth }.sort[-1]
    end
end