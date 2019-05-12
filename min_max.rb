require './defs'
require './point'

class MinMax

  attr_reader :left
  attr_reader :right

  def initialize(seesaw)
    @seesaw = seesaw

    # We use Point as a container for maximum (x) and minimum (y)
    @left  = Point.new(@seesaw.origin.y, @seesaw.origin.y)
    @right = Point.new(@seesaw.origin.y, @seesaw.origin.y)
  end

  def update(p_left, p_right)
    @left.x  = p_left.y  if p_left.y  < @left.x
    @left.y  = p_left.y  if p_left.y  > @left.y

    @right.x = p_right.y if p_right.y < @right.x
    @right.y = p_right.y if p_right.y > @right.y
  end

  def draw
    @seesaw.window.draw_line(0, @left.x, 0xFFFF0000, Defs::WINDOW[:CENTER], @left.x, 0xFFFF0000)
    @seesaw.window.font.draw_text("LHI: #{@left.x.round(2)}", 5, @left.x - 20, 0)

    @seesaw.window.draw_line(0, @left.y, 0xFFFF0000, Defs::WINDOW[:CENTER], @left.y, 0xFFFF0000)
    @seesaw.window.font.draw_text("LLO: #{@left.y.round(2)}", 5, @left.y, 0)

    @seesaw.window.draw_line(Defs::WINDOW[:CENTER], @right.x, 0xFF0000FF, Defs::WINDOW[:WIDTH], @right.x, 0xFF0000FF)
    @seesaw.window.font.draw_text("RHI: #{@right.x.round(2)}", Defs::WINDOW[:WIDTH] - 110, @right.x - 20, 0)

    @seesaw.window.draw_line(Defs::WINDOW[:CENTER], @right.y, 0xFF0000FF, Defs::WINDOW[:WIDTH], @right.y, 0xFF0000FF)
    @seesaw.window.font.draw_text("RLO: #{@right.y.round(2)}", Defs::WINDOW[:WIDTH] - 110, @right.y, 0)
  end

end