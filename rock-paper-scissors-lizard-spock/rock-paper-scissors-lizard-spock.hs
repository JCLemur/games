#!/usr/bin/env runhaskell

{-|
  = Rock, Paper, Scissors, Lizard, Spock

  An extension of the "Rock, Paper, Scissors" game, as seen on "The Big Bang
  Theory".

  The rule extensions for the two new gestures, Lizard and Spock, are:

  - Rock crushes lizard.
  - Scissors decapitate lizard.
  - Lizard eats paper.
  - Lizard poisons Spock.
  - Paper disproves Spock.
  - Spock vaporizes rock.
  - Spock bends scissors.

  Copyright (c) 2014 Jochen Kupperschmidt (http://homework.nwsnet.de/)
  Date: 02-Mar-2014
  Licensed under the terms of the MIT license
-}

import qualified Data.Set as Set
import Test.HUnit


data Gesture = Rock | Paper | Scissors | Lizard | Spock deriving (Eq, Ord, Show)

data VersusResult = Won | Tie | Lost deriving (Eq, Show)


versus :: Gesture -> Gesture -> (VersusResult, VersusResult)
versus x y
    | x == y           = (Tie, Tie)
    | x `superiorTo` y = (Won, Lost)
    | otherwise        = (Lost, Won)

superiorTo :: Gesture -> Gesture -> Bool
superiorTo x y = Set.member y $ getGesturesInferiorTo x

getGesturesInferiorTo :: Gesture -> Set.Set Gesture
getGesturesInferiorTo Rock     = Set.fromList [Scissors, Lizard  ]
getGesturesInferiorTo Paper    = Set.fromList [Rock,     Spock   ]
getGesturesInferiorTo Scissors = Set.fromList [Paper,    Lizard  ]
getGesturesInferiorTo Lizard   = Set.fromList [Paper,    Spock   ]
getGesturesInferiorTo Spock    = Set.fromList [Rock,     Scissors]


-- tests

versusTests = map toTest [
    (Rock,     Rock,     (Tie,  Tie )),
    (Rock,     Paper,    (Lost, Won )),
    (Rock,     Scissors, (Won,  Lost)),
    (Rock,     Lizard,   (Won,  Lost)),
    (Rock,     Spock,    (Lost, Won )),
    (Paper,    Rock,     (Won,  Lost)),
    (Paper,    Paper,    (Tie,  Tie )),
    (Paper,    Scissors, (Lost, Won )),
    (Paper,    Lizard,   (Lost, Won )),
    (Paper,    Spock,    (Won,  Lost)),
    (Scissors, Rock,     (Lost, Won )),
    (Scissors, Paper,    (Won,  Lost)),
    (Scissors, Scissors, (Tie,  Tie )),
    (Scissors, Lizard,   (Won,  Lost)),
    (Scissors, Spock,    (Lost, Won )),
    (Lizard,   Rock,     (Lost, Won )),
    (Lizard,   Paper,    (Won,  Lost)),
    (Lizard,   Scissors, (Lost, Won )),
    (Lizard,   Lizard,   (Tie,  Tie )),
    (Lizard,   Spock,    (Won,  Lost)),
    (Spock,    Rock,     (Won,  Lost)),
    (Spock,    Paper,    (Lost, Won )),
    (Spock,    Scissors, (Won,  Lost)),
    (Spock,    Lizard,   (Lost, Won )),
    (Spock,    Spock,    (Tie,  Tie ))]
    where
        toTest :: (Gesture, Gesture, (VersusResult, VersusResult)) -> Test
        toTest (x, y, expected) = label . TestCase $ assertEqual "" actual expected
            where
                actual = x `versus` y
                label = TestLabel (show x ++ " vs. " ++ show y)

main = runTestTT (TestList versusTests)
