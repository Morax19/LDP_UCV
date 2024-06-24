data Character = Character String Int Int [Technique] deriving (Show, Eq)
data Technique = Technique String Int deriving (Show, Eq)
data Response = Wrong String | Success Character deriving (Show, Eq)

{-      Función para crear un personaje                         -}
createCharacter :: String -> Int -> Int -> [Technique] -> Response
createCharacter nombre nivP hpInit listTech
            | comprobarNombre nombre && comprobarNivP nivP && comprobarHP hpInit && comprobarTec listTech = Success (Character nombre nivP hpInit listTech)
            | otherwise = Wrong "Invalid input data"

{-      Función para comprobar que el personaje tenga un nombre no vacío        -}
comprobarNombre :: String -> Bool
comprobarNombre nombre
                | null nombre || nombre == "" = False
                | otherwise = True

{-      Función para comprobar el nivel de poder de un personaje        -}
comprobarNivP :: Int -> Bool
comprobarNivP nivP
                | (nivP>0)&&(nivP<11) = True
                | otherwise = False

{-      Función para comprobar la cantidad de vida de un personaje      -}
comprobarHP :: Int -> Bool
comprobarHP hp
                | hp>0 = True
                | otherwise = False

{-      Función para comprobar la validez de una lista de técnicas      -}
comprobarTec :: [Technique] -> Bool
comprobarTec ((Technique nombre poder):xs)
                | null nombre || nombre == "" || poder<=0 = False       
                | null xs = True
                | otherwise = comprobarTec xs

----------------------------------------------------------------
{-      Función que comprueba la validez de una técnica individual      -}
comprobarTec2 :: Technique -> Bool
comprobarTec2 (Technique nombre poder)
                | null nombre || nombre == "" || poder<=0 = True
                | otherwise = False

{-      Función que permite comparar 2 técnicas                         -}
compararTec :: [Technique] -> Technique -> Bool
compararTec ((Technique tecName tecPower):xs) (Technique newTech powerNewTech)
                    | tecName == newTech = True
                    | null xs = False
                    | tecName /= newTech = compararTec xs (Technique newTech powerNewTech)

{-      Función que permite agregar una técnica a un personaje          -}
learnTechnique :: Character -> Technique -> Response
learnTechnique (Character nombre nivP hpInit listTech) (Technique newTech powerNewTech)
                | not (comprobarNombre nombre && comprobarNivP nivP && comprobarHP hpInit && comprobarTec listTech) = Wrong "Invalid character"
                | comprobarTec2 (Technique newTech powerNewTech) = Wrong "Invalid technique"
                | compararTec listTech (Technique newTech powerNewTech) = Wrong "Technique already learned"
                | otherwise = Success (Character nombre nivP hpInit (listTech++[Technique newTech powerNewTech]))

{-      Función que permite ordenar una lista de técnicas por poder     -}
sortTechniques:: [Technique] -> [Technique]
sortTechniques [] = []
sortTechniques (Technique tecNx tecPx:xs) = sortTechniques menores ++ [Technique tecNx tecPx] ++ sortTechniques mayores
        where
                menores = [Technique tecNy tecPy | (Technique tecNy tecPy)<-xs, tecNy <= tecNx]
                mayores = [Technique tecNz tecPz | (Technique tecNz tecPz)<-xs, tecNz > tecNx]

---------------------------------------------------------------------------
{-      Retorna el ganador de un combate entre 2 personajes    -}
battle :: Character -> Character -> String -> (String, Int)
battle (Character nombre1 nivP1 hpInit1 listTech1) (Character nombre2 nivP2 hpInit2 listTech2) techToUse
        |techToUse == "first" = fight (Character nombre1 nivP1 hpInit1 listTech1) (Character nombre2 nivP2 hpInit2 listTech2) (head listTech1) (head listTech2) 
        |techToUse == "last" = fight (Character nombre1 nivP1 hpInit1 listTech1) (Character nombre2 nivP2 hpInit2 listTech2) (last listTech1) (last listTech2) 

fight :: Character -> Character-> Technique-> Technique-> (String, Int) 
fight (Character nombre1 nivP1 hpInit1 listTech1) (Character nombre2 nivP2 hpInit2 listTech2) (Technique nombTec1 powerTech1) (Technique nombTec2 powerTech2)
        |res1>0 && res2>0 = fight (Character nombre1 nivP1 res1 listTech1) (Character nombre2 nivP2 res2 listTech2) (Technique nombTec1 powerTech1) (Technique nombTec2 powerTech2)
        |res1>0 && res2<=0 = (nombre1, res1)
        |res1<=0 && res2>0 = (nombre2, res2)
        |res1<=0 && res2<=0 = ("Tie", 0)
        where
                res1=hpInit1-(nivP2*powerTech2)
                res2=hpInit2-(nivP1*powerTech1)

{-      Retorna el ganador de un combate a muerte entre 2 personajes     -}
battle2 :: Character -> Character -> Character
battle2 (Character nombre1 nivP1 hpInit1 ((Technique nombTec1 powerTech1):xs)) (Character nombre2 nivP2 hpInit2 ((Technique nombTec2 powerTech2):ys))
        |res1>0 && res2>0 = battle2(Character nombre1 nivP1 res1 [Technique nombTec1 powerTech1]) (Character nombre2 nivP2 res2 [Technique nombTec2 powerTech2])
        |res1>0 && res2<=0 = Character nombre1 nivP1 res1 [Technique nombTec1 powerTech1]
        |res1<=0 && res2>0 = Character nombre2 nivP2 res2 [Technique nombTec2 powerTech2]
        |res1<=0 && res2<=0 = Character "" 0 0 []
        where
                res1=hpInit1-(nivP2*powerTech2)
                res2=hpInit2-(nivP1*powerTech1)

{-      Función que implementa el torneo del poder con una lista de personajes  -}
tournamentOfPower:: [Character] -> (String,Int)
tournamentOfPower[]=("Error",0)
-- Acá se elimino el "" por un _ dado que no nos importa el nombre del personaje
tournamentOfPower[Character _ 0 0 []]=("Tie",0)
-- Acá se eliminaron los paréntesis del personaje, cualquier error, volver a agregar
tournamentOfPower[Character nombre1 nivP1 hpInit1 listTech] = (nombre1,hpInit1)
tournamentOfPower (x:y:xs) = tournamentOfPower newList
        where
                newList= xs++[battle2 x y]