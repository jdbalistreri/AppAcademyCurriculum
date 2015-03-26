require_relative 'deck'


class Hand
  attr_accessor :cards

  HAND_RANKS = {straight_flush: 1,
                four_of_a_kind: 2,
                full_house: 3,
                flush: 4,
                straight: 5,
                three_of_a_kind: 6,
                two_pair: 7,
                one_pair: 8,
                high_card: 9}

  def initialize(deck = nil, cards = nil)
    @deck = deck || Deck.new
    @cards = cards || []
  end

  def draw
    until @cards.count >= 5
      @cards += @deck.deal(1)
    end
  end

  def discard(indices)
    discarded = []

    indices.each do |i|
      discarded << @cards[i]
      cards[i] = nil
    end

    @cards.compact!

    @deck.receive_cards(discarded)
  end

  def beats?(other_hand)
    HAND_RANKS[hand_type] < HAND_RANKS[other_hand.hand_type]
  end

  def hand_type
    if straight_flush?
      :straight_flush
    elsif four_of_a_kind?
      :four_of_a_kind
    elsif full_house?
      :full_house
    elsif flush?
      :flush
    elsif straight?
      :straight
    elsif three_of_a_kind?
      :three_of_a_kind
    elsif two_pair?
      :two_pair
    elsif one_pair?
      :one_pair
    else
      :high_card
    end
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    num_of_a_kind.include?(4)
  end

  def full_house?
    num_of_a_kind.include?(3) && num_of_a_kind.include?(2)
  end

  def three_of_a_kind?
    num_of_a_kind.include?(3) && !full_house?
  end

  def two_pair?
    num_of_a_kind.count(2) == 2 && !full_house?
  end

  def one_pair?
    num_of_a_kind.include?(2) && !two_pair? && !full_house?
  end

  def flush?
    @cards.map(&:suit).uniq.count == 1
  end

  def straight?
    card_values = @cards.map(&:poker_value).sort
    if card_values.include?(14)
      (2..5).to_a.all?   { |value| card_values.include?(value) } ||
      (10..13).to_a.all? { |value| card_values.include?(value) }
    else
      min = card_values.min
      4.times do |i|
        return false unless card_values.include?(min + i + 1)
      end
      true
    end
  end

  def high_card_value

    #if you'er a striaght etc.
      #we do this

    #else
      #we do this

  end

  def num_of_a_kind
    card_values.values
  end

  def card_values
    card_values = Hash.new(0)

    @cards.map(&:poker_value).each { |val| card_values[val] += 1 }
    card_values
  end

end
