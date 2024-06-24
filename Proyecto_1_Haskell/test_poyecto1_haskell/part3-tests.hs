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

createTestBattle:: String -> (String, Int) -> Character -> Character -> String -> Test
createTestBattle testName expected fighter1@(Character name1 _ _ _) fighter2@(Character name2 _ _ _) technique  = 
    TestCase (assertEqual ("for (" ++ testName ++ " " ++ name1 ++ " vs " ++ name2 ++ ")") expected (battle fighter1 fighter2 technique))

test17 = createTestBattle "battle" ("Tie", 0) goku vegeta "first"
test18 = createTestBattle "battle" ("Jiren", 94000) vegeta jiren "last"
test19 = createTestBattle "battle" ("Goku", 10000) jiren goku "last"
test20 = createTestBattle "battle" ("Goku", 64000) vegeta goku "last"
test21 = createTestBattle "battle" ("Hit", 44000) (Character "Hit" 9 100000 [Technique "Pure Progress" 5000 , Technique "Time Skip" 20000]) (Character "Vegeta" 8 110000 [Technique "Final Flash" 6000, Technique "Big Bang Attack" 7000])  "last"
test22 = createTestBattle "battle" ("Monaka", 4500) mrSatan monaka "first"
test23 = createTestBattle "battle" ("Tie", 0) (Character "Hit" 9 100000 [Technique "Pure Progress" 5000 , Technique "Time Skip" 20000]) (Character "Vegeta" 8 110000 [Technique "Final Flash" 6000, Technique "Big Bang Attack" 7000])  "first"

-- Test list
tests = TestList [test17, test18, test19, test20, test21, test22, test23]

-- Run the tests
main = runTestTT tests