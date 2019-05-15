module Defs

  PI = Math::PI

  HALFPI = PI / 2.0

  RATE = 0.025 

  WINDOW = {
    HEIGHT: 1200,
    WIDTH:  1000
  }

  WINDOW[:CENTER] = WINDOW[:WIDTH] / 2

  GROUND = 1150

  SERVO = {
    X:      Defs::WINDOW[:CENTER],
    Y:      1000,
    LENGTH: 100
  }

  SEESAW = {
    Y: 500,
    ARM: {
      LENGTH:          300,
      ANCHOR_DISTANCE: 150  # Must be equal to or lesser than LENGTH
    }
  }

end