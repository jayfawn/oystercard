require 'oystercard'

describe Oystercard do

  it "should initialize with a balance of zero" do
    expect(subject.balance).to eq(0)
  end
end
