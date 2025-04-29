module BrilloMain (run) where 

import Brillo 
import Brillo.Data.Color
import Brillo.Data.Display
import Brillo.Data.Picture
import Brillo.Interface.IO.Interact

import Plant 

-- Converting a Plant to Picture
plantToPicture :: Float -> Int -> Int -> Plant -> Picture 
plantToPicture yOffset selected index plant = 
    let textColor = if index == selected then brownish else darkGreen 
    in translate (-200) (yOffset - fromIntegral index * 50) $
    color textColor $
    scale 0.15 0.15 $ 
    text (commonName plant)

-- Convert a list of Plants to a Picture 
plantsToPicture :: Int -> [Plant] -> Picture 
plantsToPicture selected plants = 
    pictures (zipWith (plantToPicture 250 selected) [0..] plants)

-- Key input event handler
handleInput :: Event -> (Int, [Plant]) -> (Int, [Plant])
handleInput (EventKey (SpecialKey KeyUp) Down _ _) (sel, ps) =
    (max 0 (sel - 1), ps)
handleInput (EventKey (SpecialKey KeyDown) Down _ _) (sel, ps) =
    (min (length ps - 1) (sel + 1), ps)
handleInput _ state = state 

-- Animation step 
step :: Float -> (Int, [Plant]) -> (Int, [Plant])
step _ state = state 

-- Current state 
draw :: (Int, [Plant]) -> Picture 
draw (selected, plants) = plantsToPicture selected plants 

-- Color definitions
beige :: Color
beige = makeColor 0.93 0.87 0.71 1.0

darkGreen :: Color 
darkGreen = makeColor 0.325 0.439 0.086 1.0

brownish :: Color 
brownish = makeColor 0.388 0.29 0.043 1.0

-- 
run :: IO ()
run = play 
    (InWindow "Native Plant Catalog" (800, 600) (10, 10))
    beige 
    30
    (0, testPlants)
    draw
    handleInput
    step