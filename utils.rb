module Utils

  def self.timewave
    Time.now.to_f
  end

  def self.distance(p1, p2)
    dx = p1.x - p2.x
    dy = p1.y - p2.y

    Math.sqrt(dx ** 2 + dy ** 2)
  end

  def self.find_angle(a, b, c)
    cos_angle = (b ** 2 + c ** 2 - a ** 2) / (2 * b * c)

    Math.acos(cos_angle)
  end

  def self.to_deg(rad)
    rad * 57.2958
  end

end