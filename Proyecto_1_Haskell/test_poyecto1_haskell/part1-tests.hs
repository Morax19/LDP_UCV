import Proyecto1
import Test.HUnit

-- Define some Techniques
invisibleEyeBlast = Technique "Invisible Eye Blast" 2000
destructoDisk = Technique "Destructo Disk" 3000
instantTransmission = Technique "Instant Transmission" 4000
pureProgress = Technique "Pure Progress" 5000
kamehameha = Technique "Kamehameha" 6000
finalFlash = Technique "Final Flash" 6000
bigBangAttack = Technique "Big Bang Attack" 7000
spiritBomb = Technique "Spirit Bomb" 8000
powerImpact = Technique "Power Impact" 10000
timeSkip = Technique "Time Skip" 20000
ultraInstinct = Technique "Ultra Instinct" 50000

-- Define some Characters
goku = Character "Goku" 10 120000 [instantTransmission, kamehameha, ultraInstinct]
vegeta = Character "Vegeta" 8 110000 [finalFlash, bigBangAttack]
jiren = Character "Jiren" 11 150000 [invisibleEyeBlast, powerImpact]
hit = Character "Hit" 9 100000 [pureProgress, timeSkip]
piccoloWrong = Character "Piccolo" 8 0 [Technique "" 0]
mrSatan = Character "Mr. Satan" 1 10000 [Technique "Punch" 550]
monaka = Character "Monaka" 1 10000 [Technique "Punch" 1000]

-- Test cases
createTestCreateCharacter :: String -> String -> Int -> Int -> [Technique] -> Response-> Test
createTestCreateCharacter testName name powerLevel health techniques expected = 
    TestCase (assertEqual ("for (" ++ testName ++ " " ++ name ++ " " ++ show powerLevel ++ " " ++ show health ++ " " ++ show techniques ++ ")") expected (createCharacter name powerLevel health techniques))

test1 = createTestCreateCharacter "createCharacter" "Goku" 10 120000 [ultraInstinct, instantTransmission, kamehameha] (Success goku)
test2 = createTestCreateCharacter "createCharacter" "Vegeta" 8 110000 [bigBangAttack, finalFlash] (Success vegeta)
test3 = createTestCreateCharacter "createCharacter" "Jiren" 11 150000 [powerImpact, invisibleEyeBlast] (Success jiren)
test4 = createTestCreateCharacter "createCharacter" "" 8 50000 [destructoDisk] (Wrong "Invalid input data")
test5 = createTestCreateCharacter "createCharacter" "Piccolo" 8 50000 [] (Wrong "Invalid input data")
test6 = createTestCreateCharacter "createCharacter" "Krillin" 0 20000 [destructoDisk] (Wrong "Invalid input data")
test7 = createTestCreateCharacter "createCharacter" "Ten" 3 0 [invisibleEyeBlast] (Wrong "Invalid input data")
test8 = createTestCreateCharacter "createCharacter" "Piccolo" 8 50000 [Technique "" 3500] (Wrong "Invalid input data")
test9 = createTestCreateCharacter "createCharacter" "Piccolo" 8 50000 [Technique "Makankosappo" 0] (Wrong "Invalid input data")
test10 = createTestCreateCharacter "createCharacter" "" 0 0 [Technique "" 0] (Wrong "Invalid input data")
test1_1 = createTestCreateCharacter "createCharacter" "Piccolo" 6 50000 [Technique "Makankosappo" 3500,  Technique "Special Beam Canno" 2000] (Success (Character "Piccolo" 6 50000 [Technique "Special Beam Canno" 2000, Technique "Makankosappo" 3500]))
test1_2 = createTestCreateCharacter "createCharacter" "Krillin" 3 0 [Technique "" 3000] (Wrong "Invalid input data")
test1_3 = createTestCreateCharacter "createCharacter" "Goku" 10 120000 [Technique "Kamehameha" 6000,  Technique "Ultra Instinct" 50000, Technique "Instant Transmission" 4000] (Success (Character "Goku" 10 120000 [Technique "Instant Transmission" 4000, Technique "Kamehameha" 6000, Technique "Ultra Instinct" 50000]))

-- Test list
tests = TestList [test1, test1_1, test1_2, test1_3, test2, test3, test4, test5, test6, test7, test8, test9, test10]

-- Run the tests
main = runTestTT tests