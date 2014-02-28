#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Problem #1: Multiples of 3 and 5
================================

If we list all the natural numbers below 10 that are multiples
of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is
23.

Find the sum of all the multiples of 3 or 5 below 1000.
"""

try:
    from future_builtins import filter
except ImportError:
    pass  # Python 3
from itertools import count, islice
import unittest


def solve(exclusive_limit):
    inclusive_limit = exclusive_limit - 1
    numbers = islice(count(1), inclusive_limit)

    multiples = filter(multiple_of_3_or_5, numbers)

    return sum(multiples)

def multiple_of_3_or_5(x):
    return multiple_of_any(x, [3, 5])

def multiple_of_any(x, ys):
    return any(multiple_of(x, y) for y in ys)

def multiple_of(x, y):
    return x % y == 0


class Problem001TestCase(unittest.TestCase):

    def test_example(self):
        self.assertEqual(solve(10), 23)

    def test_solution(self):
        self.assertEqual(solve(1000), 233168)


if __name__ == '__main__':
    unittest.main()
