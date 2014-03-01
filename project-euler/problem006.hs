#!/usr/bin/env runhaskell

{-|
  = Problem #7: 10001st prime

  By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13,
  we can see that the 6th prime is 13.

  What is the 10 001st prime number?
-}

import Test.HUnit


solve :: Int -> Int
solve index = head $ drop (index - 1) $ filter prime [1..]

prime :: Int -> Bool
prime 0 = False
prime 1 = False
prime n = not $ any (multipleOf n) [2..n-1]

multipleOf :: Int -> Int -> Bool
multipleOf dividend divisor = dividend `mod` divisor == 0


-- tests

testExample = TestCase (assertEqual "As an example," 13 (solve 6))
testSolution = TestCase (assertEqual "As the solution," 104743 (solve 10001))

main = runTestTT (TestList [testExample, testSolution])
