# frozen_string_literal: true

describe 'user_stories' do
  let(:station) { double :station }

  before(:each) do
    @newcard = Oystercard.new
  end
  # In order to use public transport
  # As a customer
  # I want money on my card

  it 'so I can have money on an oystercard, so oystercards have money' do
    expect { @newcard.balance }.not_to raise_error
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card

  it 'adds money to the card' do
    expect { @newcard.top_up(5) }.not_to raise_error
  end

  it 'should return the new balance after topping up' do
    @newcard.top_up(5)
    expect(@newcard.balance).to eq(5)
  end

  # In order to protect my money
  # As a customer
  # I don't want to put too much money on my card

  it 'should not allow the customer to top up over Maximum balance' do
    msg = "Max balance £#{Oystercard::MAX_BALANCE} will be exceeded"
    @newcard.top_up(87)
    expect { @newcard.top_up(5) }.to raise_error msg
  end

  # In order to get through the barriers
  # As a customer
  # I need to touch in and out

  it "should update a card as 'in use' when touching in" do
    @newcard.top_up(5)
    @newcard.touch_in(station)
    expect(@newcard.in_journey?).to eq true
  end

  it "should update a card as 'not in use' when touching out" do
    @newcard.top_up(5)
    @newcard.touch_in(station)
    @newcard.touch_out
    expect(@newcard.in_journey?).to eq false
  end

  #
  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount for a single journey
  it 'should have a minimum amount for a single journey' do
    expect { @newcard.touch_in(station) }.to raise_error("Cannot begin journey: insufficient funds")
  end

  # In order to pay for my journey
  # As a customer
  # I need to pay for my journey when it's complete

  it 'should deduct the fare when touching out' do
    expect { @newcard.touch_out }.to change{ @newcard.balance }.by(-1)
  end
  #
  # In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from
  it 'should store the entry station when touching in' do
    @newcard.top_up(5)
    @newcard.touch_in(station)
    expect(@newcard.entry_station).to eq station
  end

  it 'should forget the entry station when touching out' do
    @newcard.top_up(5)
    @newcard.touch_in(station)
    @newcard.touch_out
    expect(@newcard.entry_station).to eq nil
  end

  #
  # In order to know where I have been
  # As a customer
  # I want to see to all my previous trips
  #
  # In order to know how far I have travelled
  # As a customer
  # I want to know what zone a station is in
  #
  # In order to be charged correctly
  # As a customer
  # I need a penalty charge deducted if I fail to touch in or out
  #
  # In order to be charged the correct amount
  # As a customer
  # I need to have the correct fare calculated
end
