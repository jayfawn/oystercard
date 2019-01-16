require 'journey'

describe Journey do
  it "doesn't have an entry station when a new Journey object is initialized" do
    expect(subject.entry_station).to eq nil
  end

  it "doesn't have an exit station when a new Journey object is initialized" do
    expect(subject.exit_station).to eq nil
  end
end
