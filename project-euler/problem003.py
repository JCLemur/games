#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Problem #3: Largest prime factor
================================

The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143?
"""

import unittest


def solve(n):
    return list(find_prime_factors(n))[-1]

def find_prime_factors(n):
    i = 2
    while i**2 < n:
        while multiple_of(n, i):
            yield i
            n /= i
        i += 1
    yield n

def multiple_of(x, y):
    return x % y == 0


class Problem003TestCase(unittest.TestCase):

    def test_find_prime_factors(self):
        expected = [5, 7, 13, 29]
        self.assertEqual(list(find_prime_factors(13195)), expected)

    def test_solution(self):
        self.assertEqual(solve(600851475143), 6857)


if __name__ == '__main__':
    unittest.main()
