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

createTestLearnTechnique :: String -> Response -> Character -> Technique -> Test
createTestLearnTechnique testName expected fighter@(Character name _ _ techniques) technique  = 
    TestCase (assertEqual ("for (" ++ testName ++ " " ++ name ++ " " ++ show techniques ++ ",new technique: " ++ show technique ++ ")") expected (learnTechnique fighter technique))


test11 = createTestLearnTechnique "learnTechnique" (Success(Character "Goku" 10 120000 [instantTransmission, kamehameha, spiritBomb, ultraInstinct])) goku spiritBomb
test12 = createTestLearnTechnique "learnTechnique" (Success(Character "Vegeta" 8 110000 [destructoDisk, finalFlash, bigBangAttack])) vegeta destructoDisk
test13 = createTestLearnTechnique "learnTechnique" (Success(Character "Jiren" 11 150000 [invisibleEyeBlast, finalFlash, powerImpact])) jiren finalFlash
test14 = createTestLearnTechnique "learnTechnique" (Wrong "Invalid character")  piccoloWrong instantTransmission
test15 = createTestLearnTechnique "learnTechnique" (Wrong "Invalid technique") vegeta (Technique "" 0)
test16 = createTestLearnTechnique "learnTechnique" (Wrong "Technique already learned") hit pureProgress
test11_1 = createTestLearnTechnique "learnTechnique" (Success (Character "Hit" 9 100000 [Technique "Pure Progress" 5000 , Technique "Time Skip" 20000])) (Character "Hit" 9 100000 [Technique "Time Skip" 20000]) (Technique "Pure Progress" 5000)
test11_2 = createTestLearnTechnique "learnTechnique" (Wrong "Invalid character") (Character "Trunks" 0 0 [Technique "" 0]) (Technique "Masenko" 4000)
test11_3 = createTestLearnTechnique "learnTechnique" (Wrong "Invalid technique") (Character "Jiren"  11 150000 [Technique "Power Impact" 10000]) (Technique "" 0)
test11_4 = createTestLearnTechnique "learnTechnique" (Wrong "Technique already learned") (Character "Vegeta"  8 110000 [Technique "Final Flash" 6000, Technique "Big Bang Attack" 7000]) (Technique "Final Flash" 6000)


-- Test list
tests :: Test
tests = TestList [test11, test11_1, test11_2, test11_3, test11_4, test12, test13, test14, test15, test16]

-- Run the tests
main = runTestTT tests