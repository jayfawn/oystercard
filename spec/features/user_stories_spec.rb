# frozen_string_literal: true

describe 'user_stories' do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { { entry_station: :station, exit_station: :station } }
  before(:each) do
    @newcard = Oystercard.new
  end

  it 'so I can have money on an oystercard, so oystercards have money' do
    expect { @newcard.balance }.not_to raise_error
  end

  it 'adds money to the card' do
    expect { @newcard.top_up(5) }.not_to raise_error
  end

  it 'should return the new balance after topping up' do
    @newcard.top_up(5)
    expect(@newcard.balance).to eq(5)
  end

  it 'should not allow the customer to top up over Maximum balance' do
    msg = "Max balance £#{Oystercard::MAX_BALANCE} will be exceeded"
    @newcard.top_up(87)
    expect { @newcard.top_up(5) }.to raise_error msg
  end

  it "should update a card as 'in use' when touching in" do
    @newcard.top_up(5)
    @newcard.touch_in(:station)
    expect(@newcard.in_journey?).to eq true
  end

  it "should update a card as 'not in use' when touching out" do
    @newcard.top_up(5)
    @newcard.touch_in(:station)
    @newcard.touch_out(:station)
    expect(@newcard.in_journey?).to eq false
  end

  it 'should have a minimum amount for a single journey' do
    ins_funds = 'Cannot begin journey: insufficient funds'
    expect { @newcard.touch_in(:station) }.to raise_error ins_funds
  end

  it 'should deduct the fare when touching out' do
    expect { @newcard.touch_out(:station) }.to change { @newcard.balance }.by(-1)
  end

  it 'should store the entry station when touching in' do
    @newcard.top_up(5)
    @newcard.touch_in(:station)
    expect(@newcard.entry_station).to eq :station
  end

  it 'should forget the entry station when touching out' do
    @newcard.top_up(5)
    @newcard.touch_in(:station)
    @newcard.touch_out(:station)
    expect(@newcard.entry_station).to eq nil
  end

  it 'should enable us to see a list of all journeys' do
    @newcard.top_up(5)
    @newcard.touch_in(:station)
    @newcard.touch_out(:station)
    expect(@newcard.journey_history).to include(journey)
  end
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
