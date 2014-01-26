#!/usr/bin/env julia

# Fizz Buzz
# =========
#
# A functional programming-orientated implementation of the Fizz Buzz
# game (see http://en.wikipedia.org/wiki/Fizzbuzz).
#
# Copyright (c) 2014 Jochen Kupperschmidt (http://homework.nwsnet.de/)
# Date: 26-Jan-2014
# Licensed under the terms of the MIT license

using Base.Test


divisible_by(dividend, divisor) = dividend % divisor == 0
divisible_by_3(x) = divisible_by(x, 3)
divisible_by_5(x) = divisible_by(x, 5)
divisible_by_3_and_5(x) = divisible_by_3(x) && divisible_by_5(x)

REPLACEMENTS = [
    (divisible_by_3_and_5, "Fizz Buzz"),
    (divisible_by_3, "Fizz"),
    (divisible_by_5, "Buzz"),
]

# Return the replacement defined for the given number, or the number
# itself.
function replace(x)
    for (predicate, replacement) in REPLACEMENTS
        if predicate(x)
            return replacement
        end
    end
    string(x)
end

# Generate the Fizz Buzz sequence from 1 the given limit (inclusive).
fizzbuzz(limit) = map(replace, 1:limit)

function test_fizzbuzz()
    expected = [
        "1",    "2",    "Fizz", "4",    "Buzz",
        "Fizz", "7",    "8",    "Fizz", "Buzz",
        "11",   "Fizz", "13",   "14",   "Fizz Buzz",
        "16",   "17",   "Fizz", "19",   "Buzz",
        "Fizz", "22",   "23",   "Fizz", "Buzz",
        "26",   "Fizz", "28",   "29",   "Fizz Buzz",
        "31",   "32",   "Fizz", "34",   "Buzz",
        "Fizz", "37",   "38",   "Fizz", "Buzz",
    ]
    @test fizzbuzz(40) == expected
    println("Test was successful.")
end

test_fizzbuzz()
