class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up
    @balance += 5
  end
end
