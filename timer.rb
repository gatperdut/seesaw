require './defs'

class Timer

  attr_reader :t
  attr_reader :running

  def initialize
    @t = 0.0

    @running = false
    toggle
  end

  def update
    @t = @t + Defs::RATE if @running
  end

  def toggle
    puts "running" if !@running
    puts "stoping" if @running
    @running = !@running
  end

end