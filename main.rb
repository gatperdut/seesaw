require 'gosu'
require 'byebug'

require './utils'
require './servo'
require './seesaw'
require './defs'

class Window < Gosu::Window
  attr_reader :font

  def initialize(width=Defs::WINDOW[:WIDTH], height=Defs::WINDOW[:HEIGHT])
    super
    self.caption = 'Seesaw'

    @servo = Servo.new(self)

    @seesaw = Seesaw.new(self, @servo)

    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update
    @servo.update
    @seesaw.update
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  def needs_cursor?
    true
  end

  def needs_redraw?
    true
  end

  def draw
    @scene_ready ||= true
    @servo.draw
    @seesaw.draw
    draw_info
  end

  private

  def line(l)
    20 * l
  end

  def draw_info
    @font.draw_text("Stick length: #{@seesaw.computed_stick_length.round(2)} (#{@seesaw.stick_length.round(2)})", 5, line(0), 0)
  end
end

window = Window.new
window.show
