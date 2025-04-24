

module Main where

import Brillo

main :: IO()

main = display
  (InWindow "Window Title" (800, 600) (10, 10))
  yellow
  (Circle 125)

