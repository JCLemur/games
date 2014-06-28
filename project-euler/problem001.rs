/// Problem #1: Multiples of 3 and 5
///
/// If we list all the natural numbers below 10 that are multiples
/// of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is
/// 23.
///
/// Find the sum of all the multiples of 3 or 5 below 1000.

use std::iter::AdditiveIterator;


fn solve(exclusive_limit: uint) -> uint {
    range(1, exclusive_limit)
        .filter(|&x| is_divisible_by(x, 3) || is_divisible_by(x, 5))
        .sum()
}

fn is_divisible_by(dividend: uint, divisor: uint) -> bool {
    dividend % divisor == 0
}

fn main() {
    println!("{}", solve(10));
}

#[test]
fn test_10() {
    assert!(solve(10) == 23);
}

#[test]
fn test_1000() {
    assert!(solve(1000) == 233168);
}
