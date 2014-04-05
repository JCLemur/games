#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Rock, Paper, Scissors, Lizard, Spock
====================================

An extension of the "Rock, Paper, Scissors" game, as seen on "The Big Bang
Theory".

The rule extensions for the two new gestures, Lizard and Spock, are:

- Rock crushes lizard.
- Scissors decapitate lizard.
- Lizard eats paper.
- Lizard poisons Spock.
- Paper disproves Spock.
- Spock vaporizes rock.
- Spock bends scissors.


Requirements
------------

At least version 2.7 of Python is required. The code should work with
Python 3.1 and later as well, but only has been tested on versions 3.3
and 3.4.

On Python before version 3.4, the 'enum34' package must be installed
separately:

.. code:: sh

    $ pip install enum34


Tests
-----

Install nose2 (tested with version 0.4.6):

.. code:: sh

    $ pip install nose2

Then run them (specifying the module name, not the file name):

.. code:: sh

    $ nose2 rock-paper-scissors-lizard-spock

Note: Because the pseudo-random numbers of the built-in 'random'
module are not reproducible across Python versions, the report tests
are currently only working on Python 2.7


:Copyright: 2013-2014 `Jochen Kupperschmidt <http://homework.nwsnet.de/>`_
:Date: 05-Apr-2014
:License: MIT
"""

from __future__ import print_function
from collections import Counter, defaultdict, namedtuple
from enum import Enum
from itertools import combinations, islice
import random
import unittest

from nose2.tools import params


Player = namedtuple('Player', ['name', 'throw_gesture'])

Gesture = Enum('Gesture', 'Rock Paper Scissors Lizard Spock')

VersusResult = Enum('VersusResult', 'Won Tie Lost')


SUPERIOR_TO_INFERIOR_GESTURES = {
    Gesture.Rock:     {Gesture.Scissors, Gesture.Lizard},
    Gesture.Paper:    {Gesture.Rock,     Gesture.Spock},
    Gesture.Scissors: {Gesture.Paper,    Gesture.Lizard},
    Gesture.Lizard:   {Gesture.Paper,    Gesture.Spock},
    Gesture.Spock:    {Gesture.Rock,     Gesture.Scissors},
}

POINTS = {
    VersusResult.Won: 1.0,
    VersusResult.Tie: 0.5,
    VersusResult.Lost: 0.0,
}

PLAYERS = [
    Player('A', lambda: Gesture.Paper),
    Player('B', lambda: random.choice(list(Gesture))),
]


def generate_rounds(players):
    """Return a generator that, on every iteration, compares the players'
    gestures and returns their respective points.
    """
    while True:
        names_and_points = [(name, POINTS[versus_result])
            for name, versus_result in generate_versus_results(players)]
        yield defaultdict(float, names_and_points)

def generate_versus_results(players):
    """Determine all the versus results for all combinations of gestures
    thrown by players.
    """
    player_names_and_gestures = ((p.name, p.throw_gesture()) for p in players)
    versus_combinations = combinations(player_names_and_gestures, 2)
    for (name1, gesture1), (name2, gesture2) in versus_combinations:
        versus_result1, versus_result2 = compare_gestures(gesture1, gesture2)
        yield name1, versus_result1
        yield name2, versus_result2

def compare_gestures(gesture1, gesture2):
    """Compare the gestures and return a pair of versus results."""
    if gesture1 == gesture2:
        return VersusResult.Tie, VersusResult.Tie

    if is_gesture_superior_to(gesture1, gesture2):
        return VersusResult.Won, VersusResult.Lost
    else:
        return VersusResult.Lost, VersusResult.Won

def is_gesture_superior_to(gesture1, gesture2):
    """Return true if gesture 1 is superior to gesture 2."""
    return gesture2 in SUPERIOR_TO_INFERIOR_GESTURES[gesture1]

def report(round_results):
    """Aggregate round results and generate result messages."""
    counter = Counter()
    for round_result in round_results:
        counter.update(round_result)

    name_width = max(map(len, counter.keys()))
    points_width = len(str(max(counter.values())))
    for name, points in sorted(counter.items()):
        yield 'Player {:{name_width}} has {:{point_width}.1f} points.'.format(
            name, points, name_width=name_width, point_width=points_width)

def play(players, round_count, report_write_func=print):
    """Play a match with the given players and the given number of rounds."""
    round_generator = generate_rounds(players)
    round_results = islice(round_generator, round_count)
    for line in report(round_results):
        report_write_func(line)


class Test(unittest.TestCase):

    @params(
        (Gesture.Rock,     Gesture.Rock,     (VersusResult.Tie,  VersusResult.Tie)),
        (Gesture.Rock,     Gesture.Paper,    (VersusResult.Lost, VersusResult.Won)),
        (Gesture.Rock,     Gesture.Scissors, (VersusResult.Won,  VersusResult.Lost)),
        (Gesture.Rock,     Gesture.Lizard,   (VersusResult.Won,  VersusResult.Lost)),
        (Gesture.Rock,     Gesture.Spock,    (VersusResult.Lost, VersusResult.Won)),
        (Gesture.Paper,    Gesture.Rock,     (VersusResult.Won,  VersusResult.Lost)),
        (Gesture.Paper,    Gesture.Paper,    (VersusResult.Tie,  VersusResult.Tie)),
        (Gesture.Paper,    Gesture.Scissors, (VersusResult.Lost, VersusResult.Won)),
        (Gesture.Paper,    Gesture.Lizard,   (VersusResult.Lost, VersusResult.Won)),
        (Gesture.Paper,    Gesture.Spock,    (VersusResult.Won,  VersusResult.Lost)),
        (Gesture.Scissors, Gesture.Rock,     (VersusResult.Lost, VersusResult.Won)),
        (Gesture.Scissors, Gesture.Paper,    (VersusResult.Won,  VersusResult.Lost)),
        (Gesture.Scissors, Gesture.Scissors, (VersusResult.Tie,  VersusResult.Tie)),
        (Gesture.Scissors, Gesture.Lizard,   (VersusResult.Won,  VersusResult.Lost)),
        (Gesture.Scissors, Gesture.Spock,    (VersusResult.Lost, VersusResult.Won)),
        (Gesture.Lizard,   Gesture.Rock,     (VersusResult.Lost, VersusResult.Won)),
        (Gesture.Lizard,   Gesture.Paper,    (VersusResult.Won,  VersusResult.Lost)),
        (Gesture.Lizard,   Gesture.Scissors, (VersusResult.Lost, VersusResult.Won)),
        (Gesture.Lizard,   Gesture.Lizard,   (VersusResult.Tie,  VersusResult.Tie)),
        (Gesture.Lizard,   Gesture.Spock,    (VersusResult.Won,  VersusResult.Lost)),
        (Gesture.Spock,    Gesture.Rock,     (VersusResult.Won,  VersusResult.Lost)),
        (Gesture.Spock,    Gesture.Paper,    (VersusResult.Lost, VersusResult.Won)),
        (Gesture.Spock,    Gesture.Scissors, (VersusResult.Won,  VersusResult.Lost)),
        (Gesture.Spock,    Gesture.Lizard,   (VersusResult.Lost, VersusResult.Won)),
        (Gesture.Spock,    Gesture.Spock,    (VersusResult.Tie,  VersusResult.Tie)),
    )
    def test_compare_gestures(self, gesture1, gesture2, expected):
        actual = compare_gestures(gesture1, gesture2)
        self.assertEquals(actual, expected, '%s vs. %s' % (gesture1, gesture2))

    @params(
        (917865817,  42,  '21.5',  '20.5'),
        (592376472, 100,  '44.0',  '56.0'),
        (716592168, 200, '101.5', ' 98.5'),  # Also tests number alignment.
        (891265910, 240, '112.0', '128.0'),
        (289759283, 320, '171.0', '149.0'),
    )
    def test_report(self, seed, rounds, player1points, player2points):
        expected = [
            'Player A has %s points.' % player1points,
            'Player B has %s points.' % player2points,
        ]

        random.seed(seed)
        actual = []
        play(PLAYERS, rounds, report_write_func=actual.append)

        self.assertEquals(actual, expected)


if __name__ == '__main__':
    play(PLAYERS, 100)
