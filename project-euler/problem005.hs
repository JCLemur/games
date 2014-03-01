#!/usr/bin/env runhaskell

{-|
  = Problem #5: Smallest multiple

  2520 is the smallest number that can be divided by each of the
  numbers from 1 to 10 without any remainder.

  What is the smallest positive number that is evenly divisible
  by all of the numbers from 1 to 20?
-}

import Test.HUnit


solve :: [Int] -> Int
solve rawDivisors = head $ filter (multipleOfAllOf divisors) [1..]
    -- Start with the biggest number to increase performance by
    -- ruling out non-matching candidates earlier.
    where divisors = reverse rawDivisors


multipleOfAllOf :: [Int] -> Int -> Bool
multipleOfAllOf divisors dividend = all (multipleOf dividend) divisors

multipleOf :: Int -> Int -> Bool
multipleOf dividend divisor = dividend `mod` divisor == 0


-- tests

testExample = TestCase (assertEqual "As an example," 2520 (solve [1..10]))
testSolution = TestCase (assertEqual "As the solution," 232792560 (solve [1..20]))

main = runTestTT (TestList [testExample, testSolution])
