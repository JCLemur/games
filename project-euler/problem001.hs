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
solve exlusiveLimit = sum $ filter multipleOf3or5 xs
    where
        xs = [1..inclusiveLimit]
        inclusiveLimit = exlusiveLimit - 1

multipleOf3or5 :: Int -> Bool
multipleOf3or5 x = multipleOfAny x [3, 5]

multipleOfAny :: Int -> ([Int] -> Bool)
multipleOfAny x = any (multipleOf x)

multipleOf :: Int -> Int -> Bool
multipleOf x y = x `mod` y == 0


-- tests

testExample = TestCase (assertEqual "As an example," 23 (solve 10))
testSolution = TestCase (assertEqual "As the solution," 233168 (solve 1000))

main = runTestTT (TestList [testExample, testSolution])
