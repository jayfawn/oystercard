class Journey
attr_reader :entry_station, :exit_station

MIN_FARE = 3
PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def update_entry_station(entry_station)
    @entry_station = entry_station
  end

  def update_exit_station(exit_station)
    @exit_station = exit_station
  end

  def fare
    !@entry_station.nil? && !@exit_station.nil? ? MIN_FARE : PENALTY_FARE
  end
end
