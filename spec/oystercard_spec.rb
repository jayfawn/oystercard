# frozen_string_literal: true

require 'oystercard'

describe Oystercard do

  let(:station) { double :station }

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

  describe '#touch_in' do
    it "should update a card as 'in use' when touching in" do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end

    it "should raise an error if attempting to touch when balance too low" do
      expect { subject.touch_in(station) }.to raise_error "Cannot begin journey: insufficient funds"
    end

    it "should store the entry station when touching in" do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    it "should update a card as 'not in use' when touching out" do
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end

    it 'should deduct the fare when touching out' do
      subject.top_up(5)
      subject.touch_in(station)
      expect { subject.touch_out }.to change{ subject.balance }.by(-1)
    end

    it 'should forget the entry station on touch out' do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end
  end
end
