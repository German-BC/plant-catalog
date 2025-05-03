
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

testPlantsLg :: [Plant]
testPlantsLg = 
    [
        Plant "Blue Flax" "Linum lewisii" "Full Sun" "Low" "Spring to Summer", 
        Plant "Chocolate Flower" "Berlandiera lyrata" "Full Sun" "Low" "Summer",
        Plant "Buffalograss" "Bouteloua dactyloides" "Sun" "Low" "Summer",
        Plant "Purple Prairie Clover" "Dalea purpurea" "Sun" "Low" "Summer",
        Plant "Rocky Mountain Penstemon" "Penstemon strictus" "Sun" "Low" "Late Spring" ,
        Plant "Golden Columbine" "Aquilegia chrysantha" "Part Shade" "Medium" "Spring",
        Plant "Maximilian Sunflower" "Helianthus maximiliani" "Full Sun" "Medium" "Fall",
        Plant "Desert Marigold" "Baileya multiradiata" "Full Sun" "Low" "Spring to Fall",
        Plant "Indian Blanket" "Gaillardia pulchella" "Full Sun" "Low" "Summer",
        Plant "Firewheel" "Gaillardia aristata" "Full Sun" "Medium" "Late Spring to Fall",
        Plant "Little Bluestem" "Schizachyrium scoparium" "Sun" "Low" "Late Summer",
        Plant "Apache Plume" "Fallugia paradoxa" "Full Sun" "Low" "Spring to Fall"
    ]

