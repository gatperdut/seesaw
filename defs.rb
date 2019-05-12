module Defs

  PI = Math::PI

  HALFPI = PI / 2.0

  WINDOW = {
    HEIGHT: 850,
    WIDTH:  1000
  }

  WINDOW[:CENTER] = WINDOW[:WIDTH] / 2

  GROUND = 800

  SERVO = {
    X:      Defs::WINDOW[:CENTER],
    Y:      700,
    LENGTH: 75
  }

  SEESAW = {
    Y: 300,
    ARM: {
      LENGTH:          300,
      ANCHOR_DISTANCE: 280  # Must be equal to or lesser than LENGTH
    }
  }

end