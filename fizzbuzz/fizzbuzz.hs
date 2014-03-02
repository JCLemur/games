#!/usr/bin/env runhaskell

{-|
  = Fizz Buzz

  A functional programming-orientated implementation of the Fizz Buzz
  game (see http://en.wikipedia.org/wiki/Fizzbuzz).

  Copyright (c) 2014 Jochen Kupperschmidt (http://homework.nwsnet.de/)
  Date: 02-Mar-2014
  Licensed under the terms of the MIT license
-}

import Test.HUnit


fizzbuzz :: [String]
fizzbuzz = map replace [1..]

replace :: Int -> String
replace n
    | isDivisibleByAllOf [3, 5] n = "Fizz Buzz"
    | isDivisibleBy n 3           = "Fizz"
    | isDivisibleBy n 5           = "Buzz"
    | otherwise                   = show n

isDivisibleByAllOf :: [Int] -> Int -> Bool
isDivisibleByAllOf divisors dividend = all (isDivisibleBy dividend) divisors

isDivisibleBy :: Int -> Int -> Bool
isDivisibleBy dividend divisor = dividend `mod` divisor == 0


-- tests

main = runTestTT $ TestCase (assertEqual "As the solution," expected actual)
    where
        actual = take 40 $ fizzbuzz
        expected = [
            "1",    "2",    "Fizz", "4",    "Buzz",
            "Fizz", "7",    "8",    "Fizz", "Buzz",
            "11",   "Fizz", "13",   "14",   "Fizz Buzz",
            "16",   "17",   "Fizz", "19",   "Buzz",
            "Fizz", "22",   "23",   "Fizz", "Buzz",
            "26",   "Fizz", "28",   "29",   "Fizz Buzz",
            "31",   "32",   "Fizz", "34",   "Buzz",
            "Fizz", "37",   "38",   "Fizz", "Buzz"]
