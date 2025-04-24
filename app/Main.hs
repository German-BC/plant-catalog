

module Main where

import Brillo

main :: IO()

main = display
  (InWindow "Nice Window finally" (800, 600) (10, 10))
  yellow
  (Circle 125)

-- main :: IO ()
-- main = putStrLn "Hello, Haskell!"
