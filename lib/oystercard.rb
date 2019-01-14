# frozen_string_literal: true

# This is the Oystercard class
class Oystercard
  attr_reader :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(value)
    raise "Max balance £#{MAX_BALANCE} will be exceeded" if max_reached?(value)

    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  private

  def max_reached?(value)
    @balance + value > MAX_BALANCE
  end
end
