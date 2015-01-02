# Problem #1: Multiples of 3 and 5
# ================================
#
# If we list all the natural numbers below 10 that are multiples
# of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is
# 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

from future import `=>`
from math import sum
from sequtils import filter, foldl, toSeq


proc multipleOf(x: int, y: int): bool =
    x mod y == 0

proc multipleOfAny(x: int, ys: seq[int]): bool =
    let results = map(ys, (y: int) => multipleOf(x, y))
    foldl(results, a or b)

proc multipleOf3or5(x: int): bool =
    multipleOfAny(x, @[3, 5])

proc solve(xs: seq[int]): int =
    sum(filter(xs, multipleOf3or5))


# tests

# See issue: https://github.com/Araq/Nim/issues/1839
assert solve(toSeq(1..9)) == 23
assert solve(toSeq(1..999)) == 233168

echo "Tests were successful."
