#!/usr/bin/env julia

# Problem #4: Largest palindrome product
# ======================================
#
# A palindromic number reads the same both ways. The largest
# palindrome made from the product of two 2-digit numbers is
# 9009 = 91 × 99.
#
# Find the largest palindrome made from the product of two
# 3-digit numbers.

using Base.Test

using Iterators


function solve(factorsrange)
    factors = product(factorsrange, factorsrange)
    products = [x[1] * x[2] for x in factors]
    palindromes = filter(palindrome, products)
    maximum(palindromes)
end

function palindrome(n)
    chars = string(n)
    chars == reverse(chars)
end


# --- tests ---

test_example() = @test solve(10:99) == 9009
test_solution() = @test solve(100:999) == 906609

function run_tests()
    test_example()
    test_solution()
    println("Tests were successful.")
end

run_tests()
