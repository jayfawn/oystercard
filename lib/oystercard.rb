# frozen_string_literal: true

# This is the Oystercard class
class Oystercard
  attr_reader :balance, :entry_station
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @in_use = false
    @balance = 0
    @entry_station = nil
  end

  def top_up(value)
    raise "Max balance £#{MAX_BALANCE} will be exceeded" if max_reached?(value)

    @balance += value
  end

  def touch_in(station)
    raise "Cannot begin journey: insufficient funds" if @balance < MIN_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct(1)
    @entry_station = nil

  end

  def in_journey?
    !!entry_station
  end

  private

  def max_reached?(value)
    @balance + value > MAX_BALANCE
  end

  def deduct(value)
    @balance -= value
  end

end
