require './defs'

class Servo
  attr_reader :origin
  attr_reader :dest
  attr_reader :angle
  attr_reader :length

  include Utils

  def initialize(window)
    @window = window

    @origin = Utils::Point.new(Defs::WINDOW[:CENTER], 650)

    @dest = Utils::Point.new(0, 0)

    @angle = 0

    @length = 100
  end
 
  def update
    @angle = Utils::timewave

    @dest.x = @origin.x + Math.cos(@angle) * @length
    @dest.y = @origin.y + Math.sin(@angle) * @length
  end
 
  def draw
    @window.draw_rect(@origin.x - 8, @origin.y - 8, 16, 16, 0xFFFFFF00)

    @window.draw_line(@origin.x, @origin.y, 0xFFFF0000, @dest.x, @dest.y, 0xFFFF0000)

    @window.draw_rect(@dest.x - 5, @dest.y - 5, 10, 10, 0xFFFFFFFF)
  end
end