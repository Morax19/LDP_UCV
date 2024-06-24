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

createTestTournamentOfPower:: String -> (String, Int) -> [Character] -> Test
createTestTournamentOfPower testName expected characters  = 
    TestCase (assertEqual ("for (" ++ testName ++ " all against all " ++ show characters ++ ")") expected (tournamentOfPower characters))
    
-- test24 = createTestTournamentOfPower "tournamentOfPower" ("Goku", 120000) [jiren, hit, goku]
-- test25 = createTestTournamentOfPower "tournamentOfPower" ("Tie", 0) [jiren, goku, vegeta]
test26 = createTestTournamentOfPower "tournamentOfPower" ("Vegeta", 109450) [mrSatan, vegeta, jiren, goku, hit, monaka]

goku2 :: Character
goku2 = Character "Goku" 10 100000 [Technique "Kamehameha" 1000] 
vegeta2 = Character "Vegeta" 9 90000 [Technique "Final Flash" 900] 
jiren2 = Character "Jiren" 8 80000 [Technique "Power Impact" 800] 
toppo = Character "Toppo" 7 70000 [Technique "Justice Flash" 700] 
gohan = Character "Gohan" 8 60000 [Technique "Masenko" 600]
dyspo = Character "Dyspo" 8 60000 [Technique "Light Bullet" 600] 
hit2 = Character "Hit" 5 50000 [Technique "Time-Skip" 500] 
cabba = Character "Cabba" 4 40000 [Technique "Galick Cannon" 400] 
frost = Character "Frost" 3 30000 [Technique "Chaos Beam" 300] 
botamo = Character "Botamo" 2 20000 [Technique "Botamo Shield" 200] 

characters = [toppo, goku2, dyspo, botamo, hit2, gohan, cabba, vegeta2, jiren2, frost]

test27 = createTestTournamentOfPower "tournamentOfPower" ("Goku", 36900) characters
test28 = createTestTournamentOfPower "tournamentOfPower" ("Vegeta", 76400) [vegeta2, frost, cabba, botamo, hit2]
test29 = createTestTournamentOfPower "tournamentOfPower" ("Goku", 84300) [gohan, dyspo, hit2, goku2, frost, cabba, botamo]
test30 = createTestTournamentOfPower "tournamentOfPower" ("Tie", 0) []
test31 = createTestTournamentOfPower "tournamentOfPower" ("Jiren", 60000) [jiren2,hit2,goku2,toppo,cabba,vegeta2]

-- Test list
tests = TestList [test26, test27, test28, test29, test30, test31]

-- Run the tests
main :: IO Counts
main = runTestTT tests