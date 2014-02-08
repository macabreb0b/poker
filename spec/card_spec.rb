# -*- coding: utf-8 -*-

require 'rspec'
require 'game'

describe Card do

  subject(:card) { Card.new(:seven, :spades)}

  it "returns its suit and value as a string" do
    expect(card.to_s).to eq("7♠")
  end

  it "returns its value as a symbol" do
    expect(card.value).to eq(:seven)
  end

  it "returns its suit as a symbol" do
    expect(card.suit).to eq(:spades)
  end

  it "returns its relative value as an integer" do
    expect(card.worth).to eq(7)
  end


end