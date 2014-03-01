#!/usr/bin/env runhaskell

{-|
  = Problem #1: Multiples of 3 and 5

  If we list all the natural numbers below 10 that are multiples
  of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is
  23.

  Find the sum of all the multiples of 3 or 5 below 1000.
-}

import Test.HUnit


solve :: Int -> Int
solve limit = sum $ filter (multipleOfAnyOf [3, 5]) $ numbersUntil limit

multipleOfAnyOf :: [Int] -> Int -> Bool
multipleOfAnyOf divisors dividend = any (multipleOf dividend) divisors

multipleOf :: Int -> Int -> Bool
multipleOf dividend divisor = dividend `mod` divisor == 0

numbersUntil :: Int -> [Int]
numbersUntil limit = takeWhile (< limit) [1..]


-- tests

testExample = TestCase (assertEqual "As an example," 23 (solve 10))
testSolution = TestCase (assertEqual "As the solution," 233168 (solve 1000))

main = runTestTT (TestList [testExample, testSolution])
