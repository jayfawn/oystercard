require 'oystercard'

describe Oystercard do

  it "should initialize with a balance of zero" do
    expect(subject.balance).to eq(0)
  end

  it "should allow the user to top up their oystercard" do
    subject.top_up
    expect(subject.balance).to eq(5)
  end
end
