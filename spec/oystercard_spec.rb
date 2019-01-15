# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  describe '#initialize' do
    it 'should initialize with a balance of zero' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'should allow the user to top up their oystercard' do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end

    it 'should not allow user to top up if the end balance is > Max balance' do
      msg = "Max balance £#{Oystercard::MAX_BALANCE} will be exceeded"
      subject.top_up(87)
      expect { subject.top_up(5) }.to raise_error msg
    end
  end

  describe '#deduct' do
    it 'should allow a value to be deducted from the card' do
      subject.top_up(5)
      expect { subject.deduct 2 }.to change { subject.balance }.by(-2)
    end
  end


  describe '#touch_in' do
    it "should update a card as 'in use' when touching in" do
      subject.top_up(5)
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end

    it "should raise an error if attempting to touch when balance too low" do
      expect { subject.touch_in }.to raise_error "Cannot begin journey: insufficient funds"
    end
  end

  describe '#touch_out' do
    it "should update a card as 'not in use' when touching out" do
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end
end
