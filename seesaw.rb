require './defs'

class Seesaw
  attr_reader :stick_length
  attr_reader :computed_stick_length
  attr_reader :y_maximums

  def initialize(window, servo)
    @window = window
    @servo  = servo

    @origin          = Utils::Point.new(Defs::WINDOW[:CENTER], 250)
    @arm_length      = 300
    @anchor_distance = 280

    origins_distance = @origin.y - @servo.origin.y
    arm_anchor_offset = @anchor_distance - @servo.length

    @stick_length = Math.sqrt(origins_distance ** 2 + arm_anchor_offset ** 2)

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

    s = @stick_length
    m = @anchor_distance

    alpha = Utils::find_angle(a, d, h)
    beta = Utils::find_angle(s, m, d)

    epsilon = alpha + beta - Math::PI / 2.0

    @anchor_point = Utils::Point.new(
      @origin.x + m * Math.cos(epsilon),
      @origin.y - m * Math.sin(epsilon)
    )

    @extreme_right = Utils::Point.new(
      @origin.x + @arm_length * Math.cos(epsilon),
      @origin.y - @arm_length * Math.sin(epsilon)
    )

    @extreme_left = Utils::Point.new(
      @origin.x - @arm_length * Math.cos(epsilon),
      @origin.y + @arm_length * Math.sin(epsilon)
    )

    @y_maximums[:right][:high] = @extreme_right.y if @extreme_right.y < @y_maximums[:right][:high]
    @y_maximums[:left][:high]  = @extreme_left.y  if @extreme_left.y  < @y_maximums[:left][:high]

    @y_maximums[:right][:low]  = @extreme_right.y if @extreme_right.y > @y_maximums[:right][:low]
    @y_maximums[:left][:low]   = @extreme_left.y  if @extreme_left.y  > @y_maximums[:left][:low]

    @computed_stick_length = Utils::distance(@anchor_point, @servo.dest)

    #puts @computed_stick_length
  end

  def draw
    @window.draw_rect(@origin.x - 5, @origin.y - 5, 10, 10, 0xFFFFFF00)

    @window.draw_rect(@anchor_point.x - 5, @anchor_point.y - 5, 10, 10, 0xFF00FF00)

    @window.draw_line(@servo.dest.x, @servo.dest.y, 0xFF0000FF, @anchor_point.x, @anchor_point.y, 0xFF0000FF)

    @window.draw_line(@extreme_left.x, @extreme_left.y, 0xFFFFFFFF, @extreme_right.x, @extreme_right.y, 0xFFFFFFFF)

    @window.draw_line(0, @y_maximums[:left][:high], 0xFFFF0000, @origin.x, @y_maximums[:left][:high], 0xFFFF0000)
    a=@window.font.draw_text("LHI: #{@y_maximums[:left][:high].round(2)}", 5, @y_maximums[:left][:high] - 20, 0)

    @window.draw_line(0, @y_maximums[:left][:low], 0xFFFF0000, @origin.x, @y_maximums[:left][:low], 0xFFFF0000)
    @window.font.draw_text("LLO: #{@y_maximums[:left][:low].round(2)}", 5, @y_maximums[:left][:low] + 0, 0)

    @window.draw_line(@origin.x, @y_maximums[:right][:high], 0xFF0000FF, 800, @y_maximums[:right][:high], 0xFF0000FF)
    @window.font.draw_text("RHI: #{@y_maximums[:right][:high].round(2)}", 800 - 110, @y_maximums[:right][:high] - 20, 0)

    @window.draw_line(@origin.x, @y_maximums[:right][:low], 0xFF0000FF, 800, @y_maximums[:right][:low], 0xFF0000FF)
    @window.font.draw_text("RLO: #{@y_maximums[:right][:low].round(2)}", 800 - 110, @y_maximums[:right][:low] + 0, 0)
  end
end