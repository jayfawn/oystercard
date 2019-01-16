class JourneyLog

attr_reader :journey_class

  def initialize(journey_class = Journey.new)
    @journey_class = journey_class
    @journey_history = []
  end

  def start(entry_station)
    @journey_class.update_entry_station(entry_station)
  end

  def finish(exit_station)
    @journey_class.update_exit_station(exit_station)
  end

  def current_journey
  end
end
