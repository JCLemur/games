#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Problem #4: Largest palindrome product
======================================

A palindromic number reads the same both ways. The largest
palindrome made from the product of two 2-digit numbers is
9009 = 91 × 99.

Find the largest palindrome made from the product of two
3-digit numbers.
"""

try:
    from future_builtins import filter, map
except ImportError:
    pass  # Python 3
from itertools import permutations
from operator import mul
import unittest


def solve(factors_range):
    factors = list(permutations(factors_range, 2))
    products = map(lambda pair: mul(*pair), factors)
    palindromes = filter(palindrome, products)
    return max(palindromes)

def palindrome(n):
    chars = list(str(n))
    return chars == list(reversed(chars))


class Problem004TestCase(unittest.TestCase):

    def test_example(self):
        numbers_with_two_digits = range(11, 100)
        self.assertEqual(solve(numbers_with_two_digits), 9009)

    def test_solution(self):
        numbers_with_three_digits = range(100, 1000)
        self.assertEqual(solve(numbers_with_three_digits), 906609)


if __name__ == '__main__':
    unittest.main()
