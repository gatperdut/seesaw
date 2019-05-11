class Point

  def initialize(x, y)
    @x = x
    @y = y
  end

  def xinv
    Defs::WINDOW[:WIDTH] - @x
  end

  def yinv
    @y
  end

  def x
    @x
  end

  def y
    Defs::WINDOW[:HEIGHT] - @y
  end

  def x=(x)
    @x = x
  end

  def y=(y)
    @y = Defs::WINDOW[:HEIGHT] - y
  end

end