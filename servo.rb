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
      sin:     0.0,
      cos:     0.0,
      max:     0.0,
      min:     0.0
    }
  end
 
  def update
    tw = Utils::timewave
    @angle[:sin] = Math.sin(tw)
    @angle[:cos] = Math.cos(tw)

    @dest.x = @origin.x + @angle[:cos] * @length
    @dest.y = @origin.y + @angle[:sin] * @length
  end
 
  def draw
    draw_origin
    draw_stick
    draw_dest
  end

  private

  def draw_origin
    @window.draw_rect(@origin.x - 5, @origin.y - 5, 10, 10, 0xFFFFFF00)
  end

  def draw_stick
    @window.draw_line(@origin.x, @origin.y, 0xFFFFFFFF, @dest.x, @dest.y, 0xFFFFFFFF)
  end

  def draw_dest
    @window.draw_rect(@dest.x - 3, @dest.y - 3, 6, 6, 0xFF00FF00)
  end
end