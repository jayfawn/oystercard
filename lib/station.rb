# frozen_string_literal: true

# This is the Station class
class Station
  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end
end
