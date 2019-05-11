require './defs'
require './point'
require './min_max'

class Seesaw
  attr_reader :window
  attr_reader :origin
  attr_reader :stick_length

  def initialize(window, servo)
    @window = window
    @servo  = servo

    @origin          = Point.new(Defs::WINDOW[:CENTER], Defs::SEESAW[:Y])
    @arm_length      = Defs::SEESAW[:ARM][:LENGTH]
    @anchor_distance = Defs::SEESAW[:ARM][:ANCHOR_DISTANCE]

    origins_distance  = @origin.y - @servo.origin.y
    arm_anchor_offset = @anchor_distance - @servo.length

    @stick_length = {
      needed:   Math.sqrt(origins_distance ** 2 + arm_anchor_offset ** 2),
      computed: nil
    }

    @min_max = MinMax.new(self)

    @y_maximums = {
      left: {
        high: @origin.y,
        low:  @origin.y
      },
      right: {
        high: @origin.y,
        low:  @origin.y
      }
    }
  end

  def update
    h = Utils::distance(@origin, @servo.origin)
    d = Utils::distance(@origin, @servo.dest)
    a = Utils::distance(@servo.origin, @servo.dest)

    s = @stick_length[:needed]
    m = @anchor_distance

    alpha = Utils::find_angle(a, d, h)
    beta = Utils::find_angle(s, m, d)

    epsilon = alpha + beta - Math::PI / 2.0

    @anchor_point = Point.new(
      @origin.x    + m * Math.cos(epsilon),
      @origin.yinv + m * Math.sin(epsilon)
    )

    @extreme_right = Point.new(
      @origin.x    + @arm_length * Math.cos(epsilon),
      @origin.yinv + @arm_length * Math.sin(epsilon)
    )

    @extreme_left = Point.new(
      @origin.x    - @arm_length * Math.cos(epsilon),
      @origin.yinv - @arm_length * Math.sin(epsilon)
    )

    @min_max.update(@extreme_left, @extreme_right)

    @stick_length[:computed] = Utils::distance(@anchor_point, @servo.dest)

    #puts @stick_length[:computed]
  end

  def draw
    draw_origin
    draw_anchor
    draw_stick
    draw_arms
    
    @min_max.draw
  end

  private

  def draw_origin
    @window.draw_rect(@origin.x - 5, @origin.y - 5, 10, 10, 0xFFFFFF00)
  end

  def draw_anchor
    @window.draw_rect(@anchor_point.x - 3, @anchor_point.y - 3, 6, 6, 0xFF00FF00)
  end

  def draw_stick
    @window.draw_line(@servo.dest.x, @servo.dest.y, 0xFF00FF00, @anchor_point.x, @anchor_point.y, 0xFF00FF00)
  end

  def draw_arms
    @window.draw_line(@extreme_left.x, @extreme_left.y, 0xFFFFFFFF, @extreme_right.x, @extreme_right.y, 0xFFFFFFFF)

    draw_arm_extremes
  end

  def draw_arm_extremes
    @window.draw_rect(@extreme_left.x  - 3, @extreme_left.y  - 3, 6, 6, 0xFFFF0000)
    @window.draw_rect(@extreme_right.x - 3, @extreme_right.y - 3, 6, 6, 0xFF0000FF)
  end

end