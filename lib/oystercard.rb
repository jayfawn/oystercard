# frozen_string_literal: true
require_relative 'journey'
require_relative 'station'

# This is the Oystercard class
class Oystercard
  attr_reader :balance, :journey_history, :journey

  MAX_BALANCE = 90
  MIN_BALANCE = 5

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
    @journey_history = []
  end

  def top_up(value)
    max_reached?(value)
    @balance += value
  end

  def touch_in(entry_station)
    complete_journey unless @journey.entry_station.nil?
    sufficient_funds
    @journey.update_entry_station(entry_station)
  end

  def touch_out(exit_station)
    @journey.update_exit_station(exit_station)
    complete_journey
  end

  private

  def sufficient_funds
    raise 'Cannot begin journey: insufficient funds' if @balance < MIN_BALANCE
  end

  def complete_journey
    deduct(@journey.fare)
    update_journey_history
  end

  def update_journey_history
    @journey_history << @journey
    @journey = Journey.new
  end

  def max_reached?(value)
    raise "Max balance £#{MAX_BALANCE} will be exceeded" if @balance + value > MAX_BALANCE
  end

  def deduct(value)
    @balance -= value
  end
end
