# frozen_string_literal: true

# This is the Oystercard class
class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @in_use = false
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def top_up(value)
    raise "Max balance £#{MAX_BALANCE} will be exceeded" if max_reached?(value)

    @balance += value
  end

  def touch_in(entry_station)
    raise 'Cannot begin journey: insufficient funds' if @balance < MIN_BALANCE

    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(1)
    @exit_station = exit_station
    update_journey_history
  end

  def in_journey?
    !@entry_station != true
  end

  def update_journey_history
    journey = { entry_station: @entry_station, exit_station: @exit_station }
    @journey_history << journey
    @entry_station = nil
    @exit_station = nil
  end

  private

  def max_reached?(value)
    @balance + value > MAX_BALANCE
  end

  def deduct(value)
    @balance -= value
  end
end
