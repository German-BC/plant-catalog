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
    let textColor = if index == selected then magenta else darkGreen 
    in translate (-200) (yOffset - fromIntegral index * 75) $
    color textColor $
    scale 0.15 0.15 $ 
    text (commonName plant)

-- Convert a list of Plants to a Picture 
plantsToPicture :: Int -> [Plant] -> Picture 
plantsToPicture selected plants = 
    pictures (zipWith (plantToPicture 250 selected) [0..] plants)

-- Draw selected plant details
detailsToPicture :: Plant -> Picture 
detailsToPicture plant = 
    translate 10 200 $ 
    scale 0.15 0.15 $ 
    color brownish $ 
    pictures 
        [
            translate 0 0 (text ("Common Name: " ++ commonName plant)),
            translate 0 (-200) (text ("Botanical Name: " ++ botanicalName plant)),
            translate 0 (-400) (text ("Sun Needs: " ++ sunNeed plant)),
            translate 0 (-600) (text ("Water Use: " ++ waterNeed plant)),
            translate 0 (-800) (text ("Blooming Time: " ++ bloomTime plant))
        ]

-- Main draw function
draw :: (Int, [Plant]) -> Picture 
draw (selected, plants) = 
    pictures 
    [
        translate (-150) 0 (plantsToPicture selected plants),
        detailsToPicture (plants !! selected)
    ]

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

-- -- Current state 
-- draw :: (Int, [Plant]) -> Picture 
-- draw (selected, plants) = plantsToPicture selected plants 

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