# -*- coding: utf-8 -*-

class Card
  VALUE_STRINGS = {
    two: "2",
    three: "3",
    four: "4",
    five: "5",
    six: "6",
    seven: "7",
    eight: "8",
    nine: "9",
    ten: "10",
    jack: "J",
    queen: "Q",
    king: "K",
    ace: "A"
  }

  SUIT_STRINGS = {
    clubs: "♣",
    spades: "♠",
    hearts: "♥",
    diamonds: "♦"
  }

  WORTH = {
    two: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    seven: 7,
    eight: 8,
    nine: 9,
    ten: 10,
    jack: 11,
    queen: 12,
    king: 13,
    ace: 14
  }
  attr_reader :suit, :value

  def initialize(value, suit)
    @value, @suit = value, suit
  end

  def to_s
    VALUE_STRINGS[@value] + SUIT_STRINGS[@suit]
  end

  def worth
    WORTH[@value]
  end

end