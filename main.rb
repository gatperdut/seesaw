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
    draw_ground
    @servo.draw
    @seesaw.draw
    draw_stick_length
    draw_angle
  end

  private

  def draw_ground
    draw_rect(0, Defs::WINDOW[:HEIGHT] - Defs::GROUND, Defs::WINDOW[:WIDTH], Defs::GROUND, 0xFF8B4513)
  end

  def line(l)
    20 * l
  end

  def draw_stick_length
    @font.draw_text("Stick length: #{@seesaw.stick_length[:computed].round(2)}", 5, line(0), 0)
    @font.draw_text("(computed per frame: #{@seesaw.stick_length[:needed].round(2)})", 180, line(0), 0)
  end

  def draw_angle
    @font.draw_text("α(rad) = #{@servo.angle[:current].round(2)}", 5, line(1), 0)
    @font.draw_text("(Max: #{@servo.angle[:max].round(2)}, Min: #{@servo.angle[:min].round(2)})", 180, line(1), 0)


    @font.draw_text("α(deg) = #{Utils::to_deg(@servo.angle[:current]).round(2)}", 5, line(2), 0)
    @font.draw_text("(Max: #{Utils::to_deg(@servo.angle[:max]).round(2)}, Min: #{Utils::to_deg(@servo.angle[:min]).round(2)})", 180, line(2), 0)
  end
end

window = Window.new
window.show
