#!/usr/bin/env julia

# Problem #3: Largest prime factor
# ================================
#
# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143?

using Base.Test


function solve(n)
    i = 2
    while i * i < n
        while multiple_of(n, i)
            n /= i
        end
        i += 1
    end

    n
end

multiple_of(x, y) = x % y == 0


# --- tests ---

test_example() = @test solve(13195) == 29
test_solution() = @test solve(600851475143) == 6857

function run_tests()
    test_example()
    test_solution()
    println("Tests were successful.")
end

run_tests()
