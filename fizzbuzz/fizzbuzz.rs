/// Fizz Buzz
///
/// A functional programming-orientated implementation of the Fizz Buzz
/// game (see http://en.wikipedia.org/wiki/Fizzbuzz).
///
/// Copyright (c) 2014 Jochen Kupperschmidt (http://homework.nwsnet.de/)
/// Date: 27-Jun-2014
/// Licensed under the terms of the MIT license

use std::iter::range_inclusive;


fn fizzbuzz(limit: uint) -> ~[~str] {
    let numbers = range_inclusive(1, limit);
    numbers.map(|x| replace(x)).collect()
}

fn replace(x: uint) -> ~str {
    if is_divisible_by(x, 3) && is_divisible_by(x, 5) {
        ~"Fizz Buzz"
    } else if is_divisible_by(x, 3) {
        ~"Fizz"
    } else if is_divisible_by(x, 5) {
        ~"Buzz"
    } else {
        x.to_str()
    }
}

fn is_divisible_by(dividend: uint, divisor: uint) -> bool {
    dividend % divisor == 0
}

fn main() {
    println!("{}", fizzbuzz(40));
}

#[test]
fn test() {
    let expected = ~[
        ~"1",    ~"2",    ~"Fizz", ~"4",    ~"Buzz",
        ~"Fizz", ~"7",    ~"8",    ~"Fizz", ~"Buzz",
        ~"11",   ~"Fizz", ~"13",   ~"14",   ~"Fizz Buzz",
        ~"16",   ~"17",   ~"Fizz", ~"19",   ~"Buzz",
        ~"Fizz", ~"22",   ~"23",   ~"Fizz", ~"Buzz",
        ~"26",   ~"Fizz", ~"28",   ~"29",   ~"Fizz Buzz",
        ~"31",   ~"32",   ~"Fizz", ~"34",   ~"Buzz",
        ~"Fizz", ~"37",   ~"38",   ~"Fizz", ~"Buzz",
    ];

    assert!(fizzbuzz(40) == expected);
}
