# frozen_string_literal: true

describe 'user_stories' do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { { entry_station: :entry_station, exit_station: :exit_station } }

  describe 'Oystercard' do
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

    it 'should have a minimum amount for a single journey' do
      ins_funds = 'Cannot begin journey: insufficient funds'
      expect { @newcard.touch_in(:entry_station) }.to raise_error ins_funds
    end

    it 'should deduct the fare when touching out' do
      @newcard.top_up(10)
      @newcard.touch_in(:entry_station)
      expect { @newcard.touch_out(:exit_station) }.to change { @newcard.balance }.by(-3)
    end
  end

  describe 'Station' do
    it 'should allow a new instance of station to have a name and a zone' do
      expect { station = Station.new('name', 1) }.to_not raise_error
    end
  end
end

# In order to know how far I have travelled
# As a customer
# I want to know what zone a station is in


  # In order to be charged correctly
  # As a customer
  # I need a penalty charge deducted if I fail to touch in or out
  #
  # In order to be charged the correct amount
  # As a customer
  # I need to have the correct fare calculated
