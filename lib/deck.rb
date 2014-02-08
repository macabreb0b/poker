class Deck

  attr_reader :cards

  def initialize
    @cards = generate_cards
  end

  def generate_cards
    cards = []
    Card::SUIT_STRINGS.keys.each do |suit|
      Card::VALUE_STRINGS.keys.each do |value|
        cards << Card.new(value, suit)
      end
    end
    cards
  end

  def draw
    raise "Not enough cards left." if @cards.count == 0
    @cards.pop
  end

  def return(cards)
    cards.each do |card|
      @cards.unshift card
    end
  end

  def shuffle
    @cards.shuffle!
  end

end