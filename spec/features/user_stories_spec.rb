describe 'user_stories' do

# In order to use public transport
# As a customer
# I want money on my card
  it 'so I can have money on an oystercard, so oystercards have money' do
    newcard = Oystercard.new
    expect { newcard.balance }.not_to raise_error
  end

# In order to keep using public transport
# As a customer
# I want to add money to my card
  it 'adds money to the card' do
    newcard = Oystercard.new
    expect { newcard.top_up }.not_to raise_error
  end

  it 'should return the new balance after topping up' do
    newcard = Oystercard.new
    newcard.top_up
    expect( newcard.balance ).to eq(5)
  end

# In order to protect my money
# As a customer
# I don't want to put too much money on my card
#
# In order to pay for my journey
# As a customer
# I need my fare deducted from my card
#
# In order to get through the barriers
# As a customer
# I need to touch in and out
#
# In order to pay for my journey
# As a customer
# I need to have the minimum amount for a single journey
#
# In order to pay for my journey
# As a customer
# I need to pay for my journey when it's complete
#
# In order to pay for my journey
# As a customer
# I need to know where I've travelled from
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
