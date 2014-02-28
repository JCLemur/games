#!/usr/bin/env julia

# Problem #1: Multiples of 3 and 5
# ================================
#
# If we list all the natural numbers below 10 that are multiples
# of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is
# 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

using Base.Test


function solve(exclusive_limit)
    inclusive_limit = exclusive_limit - 1
    numbers = 1:inclusive_limit

    multiples = filter(multiple_of_3_or_5, numbers)

    sum(multiples)
end

multiple_of_3_or_5(x) = multiple_of_any(x, [3, 5])

multiple_of_any(x, ys) = any(y -> multiple_of(x, y), ys)

multiple_of(x, y) = x % y == 0


# --- tests ---

test_example() = @test solve(10) == 23
test_solution() = @test solve(1000) == 233168

function run_tests()
    test_example()
    test_solution()
    println("Tests were successful.")
end

run_tests()
