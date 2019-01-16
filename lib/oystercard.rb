# frozen_string_literal: true

require_relative 'station'

# This is the Oystercard class
class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 3

  def initialize
    @in_use = false
    @balance = 0
    #move to journey class
    @entry_station = nil
    @exit_station = nil
    #
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
    deduct(MIN_CHARGE)
    @exit_station = exit_station
    update_journey_history
  end

  #move to journey?
  def in_journey?
    !@entry_station != true
  end

  #partially move to journey
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
