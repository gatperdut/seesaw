module Defs

  WINDOW = {
    HEIGHT: 850,
    WIDTH:  1000
  }

  WINDOW[:CENTER] = WINDOW[:WIDTH] / 2

  GROUND = 50

  SERVO = {
    X:      Defs::WINDOW[:CENTER],
    Y:      150,
    LENGTH: 75
  }

  SEESAW = {
    Y: 550,
    ARM: {
      LENGTH:          300,
      ANCHOR_DISTANCE: 280  # Must be equal to or lesser than LENGTH
    }
  }

end