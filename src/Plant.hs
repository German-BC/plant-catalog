
module Plant where 

-- Plant data type
data Plant = Plant 
    { 
        botanicalName :: String,
        commonName :: String, 
        sunNeed :: String, 
        waterNeed :: String, 
        bloomTime :: String 
    }
    deriving (Show, Eq)

-- Hardcoded test plant list
testPlants :: [Plant]
testPlants = 
    [
        Plant "Linum Lewisii" "Blue Flax" "Full Sun" "Low" "Spring to Summer",
        Plant "Berlandiera Lyrata" "Chocolate Flower" "Full Sun" "Low" "Spring to Fall",
        Plant "Bouteloua Dactyloides" "Buffalograss" "Full Sun" "Very Low" "Summer"
    ]

