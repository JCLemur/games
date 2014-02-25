#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Fizz Buzz
=========

A functional programming-orientated implementation of the `Fizz Buzz`_
game.

.. _Fizz Buzz: http://en.wikipedia.org/wiki/Fizzbuzz

:Copyright: 2014 `Jochen Kupperschmidt <http://homework.nwsnet.de/>`_
:Date: 25-Feb-2014
:License: MIT
"""

try:
    from future_builtins import map
except ImportError:
    pass  # Python 3
from itertools import count, islice
import unittest


divisible_by = lambda dividend, divisor: dividend % divisor == 0

def divisible_by_all(*divisors):
    return lambda dividend: \
        all(divisible_by(dividend, divisor) for divisor in divisors)

REPLACEMENTS = [
    (divisible_by_all(3, 5), 'Fizz Buzz'),
    (divisible_by_all(3),    'Fizz'),
    (divisible_by_all(5),    'Buzz'),
]

def replace(x):
    """Return the replacement defined for the given number, or the
    number itself.
    """
    for predicate, replacement in REPLACEMENTS:
        if predicate(x):
            return replacement
    return str(x)

def fizzbuzz(limit):
    """Generate the Fizz Buzz sequence from 1 until the given limit
    (inclusive).
    """
    numbers = islice(count(1), limit)
    return map(replace, numbers)


class FizzBuzzTestCase(unittest.TestCase):

    def test(self):
        expected = [
            '1',    '2',    'Fizz', '4',    'Buzz',
            'Fizz', '7',    '8',    'Fizz', 'Buzz',
            '11',   'Fizz', '13',   '14',   'Fizz Buzz',
            '16',   '17',   'Fizz', '19',   'Buzz',
            'Fizz', '22',   '23',   'Fizz', 'Buzz',
            '26',   'Fizz', '28',   '29',   'Fizz Buzz',
            '31',   '32',   'Fizz', '34',   'Buzz',
            'Fizz', '37',   '38',   'Fizz', 'Buzz',
        ]
        actual = list(fizzbuzz(40))
        self.assertEqual(actual, expected)


if __name__ == '__main__':
    unittest.main()
