require 'journey'

describe Journey do
  let(:station1)  { double(:station) }
  let(:station2)  { double(:station) }

  it "doesn't have an entry station when a new Journey object is initialized" do
    expect(subject.entry_station).to eq nil
  end

  it "doesn't have an exit station when a new Journey object is initialized" do
    expect(subject.exit_station).to eq nil
  end

  it "should allow our update entry station method to update the entry station" do
    subject.update_entry_station(station1)
    expect(subject.entry_station).to eq station1
  end

  it "should allow our update exit station method to update the exit station" do
    subject.update_exit_station(station2)
    expect(subject.exit_station).to eq station2
  end

  it 'should return mininum fare' do
    subject.update_entry_station(station1)
    subject.update_exit_station(station2)
    expect(subject.fare).to eq(Journey::MIN_FARE)
  end

  it 'should charge penalty fare if you touch in but not out' do
    subject.update_entry_station(station1)
    expect(subject.fare).to eq(Journey::PENALTY_FARE)
  end

  it 'should charge a penalty fare if you only touch out' do
    subject.update_exit_station(station2)
    expect(subject.fare).to eq(Journey::PENALTY_FARE)
  end
end
