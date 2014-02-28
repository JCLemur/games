#!/usr/bin/env runhaskell

{-|
  = Problem #4: Largest palindrome product

  A palindromic number reads the same both ways. The largest
  palindrome made from the product of two 2-digit numbers is
  9009 = 91 × 99.

  Find the largest palindrome made from the product of two
  3-digit numbers.
-}

import Test.HUnit


solve :: [Int] -> Int
solve factorsRange = maximum palindromes
    where
        products = [x * y | x <- factorsRange, y <- [x..(last factorsRange)]]
        palindromes = filter palindrome products

palindrome :: Int -> Bool
palindrome n = chars == reverse chars
    where chars = show n

-- tests

testExample = TestCase (assertEqual "As an example," 9009 (solve [10..99]))
testSolution = TestCase (assertEqual "As the solution," 906609 (solve [100..999]))

main = runTestTT (TestList [testExample, testSolution])
