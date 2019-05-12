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
    #sleep(0.3)
    draw_ground
    @servo.draw
    @seesaw.draw
    draw_stick_length
    draw_servo_length
    draw_arm_length
    draw_angle
  end

  private

  def draw_ground
    draw_rect(0, Defs::GROUND, Defs::WINDOW[:WIDTH], Defs::GROUND, 0xFF8B4513)
  end

  def line(l)
    20 * l
  end

  def draw_stick_length
    @font.draw_text("Stick length needed: #{@seesaw.stick_length[:needed].round(2)}", 5, line(0), 0)
    @font.draw_text("(computed per frame: #{@seesaw.stick_length[:computed].round(2)})", 250, line(0), 0)
  end

  def draw_servo_length
    @font.draw_text("Servo length: #{Defs::SERVO[:LENGTH]}", 5, line(1), 0)
  end

  def draw_arm_length
    @font.draw_text("Arm length: #{Defs::SEESAW[:ARM][:LENGTH]} (Anchor distance: #{Defs::SEESAW[:ARM][:ANCHOR_DISTANCE]})", 5, line(2), 0)
  end  

  def draw_angle
    @font.draw_text("sen(rad) = #{Math.asin(@servo.angle[:sin]).round(2)}", 5, line(3), 0)
    @font.draw_text("cos(rad) = #{Math.acos(@servo.angle[:cos]).round(2)}", 5, line(4), 0)


    @font.draw_text("sen(deg) = #{Utils::to_deg(Math.asin(@servo.angle[:sin])).round(2)}", 5, line(5), 0)
    @font.draw_text("cos(deg) = #{Utils::to_deg(Math.acos(@servo.angle[:cos])).round(2)}", 5, line(6), 0)
  end
end

window = Window.new
window.show
