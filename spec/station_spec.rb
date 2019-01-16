require 'station'

  describe 'Station' do
    it 'should have a name associated with it when station object is created' do
      station = Station.new('Old Street', 1)
      expect(station.name).to eq 'Old Street'
    end

    it 'should have a zone associated with it when station object is created' do
      station = Station.new('Old Street', 1)
      expect(station.zone).to eq 1
    end
  end
