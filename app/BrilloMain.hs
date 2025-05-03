module BrilloMain (run) where 

import Brillo 
import Brillo.Interface.IO.Game

import Plant
  ( Plant(Plant), bloomTime, commonName, botanicalName, sunNeed, waterNeed,
    testPlantsLg ) 

-- Converting a Plant to Picture
plantToPicture :: Float -> Int -> Int -> Plant -> Picture 
plantToPicture yOffset selected index plant = 
    let textColor = if index == selected then magenta else darkGreen 
    in translate (-200) (yOffset - fromIntegral index * 40) $
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
    translate 10 180 $ 
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
-- draw :: (Int, [Plant]) -> Picture 
-- draw (selected, plants) = 
--     pictures 
--     [
--         -- Section backgrounds
--         translate (-200) 0 $ color (makeColor 0.87 0.78 0.64 0.5) $ rectangleSolid 390 530,
--         translate 200 0 $ color (makeColor 0.87 0.78 0.64 0.5) $ rectangleSolid 390 530,
--         -- List entries and detail view
--         translate (-190) (-40) (plantsToPicture selected plants),
--         detailsToPicture (plants !! selected)
--     ]

-- Draw UIState
draw :: UIState -> Picture 
draw (UIState page sel plants) =
    let visiblePlants = plantsOnPage page plants 
        selectedPlant = if null visiblePlants 
                        then Plant "No selection" "" "" "" ""
                        else visiblePlants !! sel 
    in pictures 
        [
            -- Section backgrounds
            translate (-200) 0 $ color (makeColor 0.87 0.78 0.64 0.5) $ rectangleSolid 390 530,
            translate 200 0 $ color (makeColor 0.87 0.78 0.64 0.5) $ rectangleSolid 390 530,

            -- plant list 
            translate (-190) (-40) (plantsToPicture sel visiblePlants),

            -- Detail view of selection
            detailsToPicture selectedPlant 
        ]                    

-- Key input event handler
--handleInput :: Event -> (Int, [Plant]) -> (Int, [Plant])
-- handleInput (EventKey (SpecialKey KeyUp) Down _ _) (sel, ps) =
--     (max 0 (sel - 1), ps)
-- handleInput (EventKey (SpecialKey KeyDown) Down _ _) (sel, ps) =
--     (min (length ps - 1) (sel + 1), ps)
-- handleInput _ state = state 
handleInput :: Event -> UIState -> IO UIState
handleInput (EventKey (SpecialKey KeyUp) Down _ _) (UIState page sel plants) =
    return $ UIState page (max 0 (sel - 1)) plants

handleInput (EventKey (SpecialKey KeyDown) Down _ _) (UIState page sel plants) =
    let maxIndex = min (pageSize - 1) (length (plantsOnPage page plants) - 1)
    in return $ UIState page (min maxIndex (sel + 1)) plants

handleInput (EventKey (SpecialKey KeyPageUp) Down _ _) (UIState page sel plants) =
    let newPage = max 0 (page - 1) 
        maxSel = length (plantsOnPage newPage plants) - 1 
    in return $ UIState newPage (min sel maxSel) plants 

handleInput (EventKey (SpecialKey KeyPageDown) Down _ _) (UIState page sel plants) =
    let totalPages = (length plants - 1) `div` pageSize
        newPage = min totalPages (page + 1)
        maxSel = length (plantsOnPage newPage plants) - 1 
    in return $ UIState newPage (min sel maxSel) plants

handleInput _ state = return state

-- Animation step 
--step :: Float -> (Int, [Plant]) -> (Int, [Plant])
step :: Float -> UIState -> IO UIState
step _ state = return state 

-- -- Current state 
-- draw :: (Int, [Plant]) -> Picture 
-- draw (selected, plants) = plantsToPicture selected plants 

-- App state record. Keep track of current page, the currently selected item,
-- and the curernt list of plants
data UIState = UIState
    {
        currentPage :: Int,
        selectedIndex :: Int, 
        plantList :: [Plant]
    }

-- Entries per page constant
pageSize :: Int 
pageSize = 10

-- Page entries subset
plantsOnPage :: Int -> [Plant] -> [Plant]
plantsOnPage page plants = take pageSize $ drop (page * pageSize) plants

-- Color definitions
beige :: Color
beige = makeColor 0.99 0.95 0.86 1.0

darkGreen :: Color 
darkGreen = makeColor 0.33 0.45 0.09 1.0

brownish :: Color 
brownish = makeColor 0.39 0.30 0.05 1.0

-- 
-- run :: IO ()
-- run = play 
--     (InWindow "Native Plant Catalog" (800, 600) (10, 10))
--     beige 
--     30
--     UIState 0 0 testPlantsLg
--     draw
--     handleInput
--     step

run :: IO ()
run = playIO
    (InWindow "Native Plant Catalog" (800, 600) (10, 10))
    beige 
    30
    (UIState 0 0 testPlantsLg)
    (pure . draw)
    handleInput
    step 
