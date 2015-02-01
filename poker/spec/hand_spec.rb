require 'rspec'
require 'hand'

describe Hand do
  let(:deck) { double("deck") }

  describe "#draw" do
    let(:hand) { Hand.new(deck) }
    it "calls the Deck#deal method" do
      expect(deck).to receive(:deal).at_least(1).times.and_return([Card.rand])
      hand.draw
    end

    it "puts the cards in the @cards array" do
      allow(deck).to receive(:deal).and_return([Card.rand])
      hand.draw
      expect(hand.cards.count).to_not eq(0)
    end

    it "draws cards until the hand is full" do
      hand.cards << Card.new(:spades, :deuce)
      allow(deck).to receive(:deal).and_return([Card.rand])
      hand.draw
      expect(hand.cards.count).to be(5)
    end
  end

  describe "#discard" do
    let(:hand) { Hand.new(deck) }

    before(:each) do
      hand.cards = [Card.new(:spades, :deuce), Card.new(:spades, :three),
                    Card.new(:spades, :four), Card.new(:spades, :five),
                    Card.new(:spades, :six)]
    end

    it "removes the cards from the hand" do
      allow(deck).to receive(:receive_cards)
      hand.discard([0,1,2,3])
      expect(hand.cards.first==(Card.new(:spades, :six))).to be(true)
    end

    it "sends the discarded cards to the deck" do
      expect(deck).to receive(:receive_cards)
      hand.discard([0,1,2,3])
    end
  end

  context "Types of Hands" do
    describe "#flush?" do
      it "returns true when a hand is a flush" do
        hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :three),
                      Card.new(:spades, :four), Card.new(:spades, :eight),
                      Card.new(:spades, :six)])
        expect(hand.flush?).to be(true)
      end

      it "returns false when a hand is not a flush" do
        hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :three),
                      Card.new(:hearts, :four), Card.new(:spades, :five),
                      Card.new(:spades, :six)])
        expect(hand.flush?).to be(false)
      end
    end
    describe "#straight?" do
      it "returns true when a hand is a straight" do
        hand = Hand.new(deck, [Card.new(:spades, :ten), Card.new(:spades, :jack),
                      Card.new(:hearts, :ace), Card.new(:spades, :queen),
                      Card.new(:spades, :king)])
        expect(hand.straight?).to be(true)
      end

      it "returns false when a hand is not a straight" do
        hand = Hand.new(deck, [Card.new(:spades, :ace), Card.new(:spades, :three),
                      Card.new(:hearts, :four), Card.new(:spades, :deuce),
                      Card.new(:hearts, :deuce)])
        expect(hand.straight?).to be(false)
      end
    end

    describe "#straight_flush?" do
      it "returns true when a hand is a straight flush" do
        hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :three),
                      Card.new(:spades, :four), Card.new(:spades, :five),
                      Card.new(:spades, :six)])
        expect(hand.straight_flush?).to be(true)
      end

      it "returns false when a hand is just a flush" do
        hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :three),
                      Card.new(:spades, :four), Card.new(:spades, :eight),
                      Card.new(:spades, :six)])
        expect(hand.straight_flush?).to be(false)
      end

      it "returns false when a hand is just a straight" do
        hand = Hand.new(deck, [Card.new(:spades, :ten), Card.new(:spades, :jack),
                      Card.new(:hearts, :ace), Card.new(:spades, :queen),
                      Card.new(:spades, :king)])
        expect(hand.straight_flush?).to be(false)
      end
    end


    describe "#four_of_a_kind?" do
      it "returns true when a hand has four of a kind" do
        hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :three),
                      Card.new(:hearts, :three), Card.new(:clubs, :three),
                      Card.new(:diamonds, :three)])
        expect(hand.four_of_a_kind?).to be(true)
      end

      it "returns false when a hand does not have four of a kind" do
        hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :three),
                      Card.new(:hearts, :three), Card.new(:clubs, :three),
                      Card.new(:diamonds, :four)])
        expect(hand.four_of_a_kind?).to be(false)
      end
    end

    describe "#full_house?" do
      it "returns true when a hand has a full house" do
        hand = Hand.new(deck, [Card.new(:diamonds, :three), Card.new(:spades, :three),
                      Card.new(:hearts, :three), Card.new(:clubs, :deuce),
                      Card.new(:diamonds, :deuce)])
        expect(hand.full_house?).to be(true)
      end

      it "returns false when a hand does not have a full house" do
        hand = Hand.new(deck, [Card.new(:diamonds, :three), Card.new(:spades, :three),
                      Card.new(:hearts, :five), Card.new(:clubs, :deuce),
                      Card.new(:diamonds, :deuce)])
        expect(hand.full_house?).to be(false)
      end
    end

    describe "#three_of_a_kind?" do
      it "returns true when a hand has three of a kind" do
        hand = Hand.new(deck, [Card.new(:diamonds, :three), Card.new(:spades, :three),
                      Card.new(:hearts, :three), Card.new(:clubs, :deuce),
                      Card.new(:diamonds, :five)])
        expect(hand.three_of_a_kind?).to be(true)
      end

      it "returns false when a hand is a full house" do
        hand = Hand.new(deck, [Card.new(:diamonds, :three), Card.new(:spades, :three),
                      Card.new(:hearts, :three), Card.new(:clubs, :deuce),
                      Card.new(:diamonds, :deuce)])
        expect(hand.three_of_a_kind?).to be(false)
      end

      it "returns false when a hand has fewer than three of a kind" do
        hand = Hand.new(deck, [Card.new(:diamonds, :three), Card.new(:spades, :three),
                      Card.new(:hearts, :five), Card.new(:clubs, :deuce),
                      Card.new(:diamonds, :deuce)])
        expect(hand.three_of_a_kind?).to be(false)
      end
    end

    describe "#two_pair?" do
      it "returns true when a hand has two pairs" do
        hand = Hand.new(deck, [Card.new(:diamonds, :three), Card.new(:spades, :three),
                      Card.new(:hearts, :deuce), Card.new(:clubs, :deuce),
                      Card.new(:diamonds, :five)])
        expect(hand.two_pair?).to be(true)
      end

      it "returns false when a hand is a full house" do
        hand = Hand.new(deck, [Card.new(:diamonds, :three), Card.new(:spades, :three),
                      Card.new(:hearts, :three), Card.new(:clubs, :deuce),
                      Card.new(:diamonds, :deuce)])
        expect(hand.two_pair?).to be(false)
      end

      it "returns false when one pair" do
        hand = Hand.new(deck, [Card.new(:diamonds, :three), Card.new(:spades, :three),
                      Card.new(:hearts, :five), Card.new(:clubs, :six),
                      Card.new(:diamonds, :seven)])
        expect(hand.two_pair?).to be(false)
      end
    end


    describe "#one_pair?" do
      it "returns true when a hand has one pair" do
        hand = Hand.new(deck, [Card.new(:diamonds, :three), Card.new(:spades, :three),
                      Card.new(:hearts, :deuce), Card.new(:clubs, :six),
                      Card.new(:diamonds, :five)])
        expect(hand.one_pair?).to be(true)
      end

      it "returns false when a hand is a full house" do
        hand = Hand.new(deck, [Card.new(:diamonds, :three), Card.new(:spades, :three),
                      Card.new(:hearts, :three), Card.new(:clubs, :deuce),
                      Card.new(:diamonds, :deuce)])
        expect(hand.one_pair?).to be(false)
      end

      it "returns false when a hand has two pair" do
        hand = Hand.new(deck, [Card.new(:diamonds, :three), Card.new(:spades, :three),
                      Card.new(:hearts, :five), Card.new(:clubs, :five),
                      Card.new(:diamonds, :seven)])
        expect(hand.one_pair?).to be(false)
      end
    end
  end

  describe "#hand_type" do
    it "correctly identifies a straight flush" do
      hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :three),
                    Card.new(:spades, :four), Card.new(:spades, :five),
                    Card.new(:spades, :six)])
      expect(hand.hand_type).to be(:straight_flush)
    end

    it "correctly identifies a straight" do
      hand = Hand.new(deck, [Card.new(:spades, :ten), Card.new(:spades, :jack),
                    Card.new(:hearts, :ace), Card.new(:spades, :queen),
                    Card.new(:spades, :king)])
      expect(hand.hand_type).to be(:straight)
    end

    it "correctly identifies a flush" do
      hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :three),
                    Card.new(:spades, :four), Card.new(:spades, :five),
                    Card.new(:spades, :nine)])
      expect(hand.hand_type).to be(:flush)
    end

    it "correctly identifies a four of a kind" do
      hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :three),
                    Card.new(:hearts, :three), Card.new(:clubs, :three),
                    Card.new(:diamonds, :three)])
      expect(hand.hand_type).to be(:four_of_a_kind)
    end

    it "correctly identifies a full house" do
      hand = Hand.new(deck, [Card.new(:diamonds, :three), Card.new(:spades, :three),
                    Card.new(:hearts, :three), Card.new(:clubs, :deuce),
                    Card.new(:diamonds, :deuce)])
      expect(hand.hand_type).to be(:full_house)
    end

    it "correctly identifies a three of a kind" do
      hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :three),
                    Card.new(:hearts, :three), Card.new(:clubs, :three),
                    Card.new(:diamonds, :four)])
      expect(hand.hand_type).to be(:three_of_a_kind)
    end

    it "correctly identifies a two pair" do
      hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :four),
                    Card.new(:hearts, :three), Card.new(:clubs, :three),
                    Card.new(:diamonds, :four)])
      expect(hand.hand_type).to be(:two_pair)
    end

    it "correctly identifies one pair" do
      hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :four),
                    Card.new(:hearts, :seven), Card.new(:clubs, :three),
                    Card.new(:diamonds, :four)])
      expect(hand.hand_type).to be(:one_pair)
    end

    it "correctly identifies high card" do
      hand = Hand.new(deck, [Card.new(:spades, :deuce), Card.new(:spades, :four),
                    Card.new(:hearts, :seven), Card.new(:clubs, :three),
                    Card.new(:diamonds, :nine)])
      expect(hand.hand_type).to be(:high_card)
    end
  end



end
