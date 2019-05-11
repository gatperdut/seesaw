require './defs'
require './utils'
require './point'

class Servo
  attr_reader :origin
  attr_reader :dest
  attr_reader :angle
  attr_reader :length

  include Utils

  def initialize(window)
    @window = window

    @origin = Point.new(Defs::SERVO[:X], Defs::SERVO[:Y])

    @dest = Point.new(0, 0)

    @length = Defs::SERVO[:LENGTH]

    @angle = {
      current: 0.0,
      max:     0.0,
      min:     0.0
    }
  end
 
  def update
    @angle[:current] = Utils::timewave
    @angle[:max]     = @angle[:current] if @angle[:current] > @angle[:max]
    @angle[:min]     = @angle[:current] if @angle[:current] < @angle[:min]

    @dest.x = @origin.x + Math.cos(@angle[:current]) * @length
    @dest.y = @origin.y + Math.sin(@angle[:current]) * @length
  end
 
  def draw
    draw_origin
    draw_stick
    draw_dest
  end

  private

  def draw_origin
    @window.draw_rect(@origin.x - 8, @origin.y - 8, 16, 16, 0xFFFFFF00)
  end

  def draw_stick
    @window.draw_line(@origin.x, @origin.y, 0xFFFF0000, @dest.x, @dest.y, 0xFFFF0000)
  end

  def draw_dest
    @window.draw_rect(@dest.x - 5, @dest.y - 5, 10, 10, 0xFFFFFFFF)
  end
end