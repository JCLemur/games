/// Rock, Paper, Scissors, Lizard, Spock
///
/// An extension of the "Rock, Paper, Scissors" game, as seen on "The
/// Big Bang Theory".
///
/// The rule extensions for the two new gestures, Lizard and Spock, are:
///
/// - Rock crushes lizard.
/// - Scissors decapitate lizard.
/// - Lizard eats paper.
/// - Lizard poisons Spock.
/// - Paper disproves Spock.
/// - Spock vaporizes rock.
/// - Spock bends scissors.
///
/// Copyright (c) 2014 Jochen Kupperschmidt (http://homework.nwsnet.de/)
/// Date: 28-Jun-2014
/// Licensed under the terms of the MIT license

extern crate collections;
use collections::HashMap;
use collections::HashSet;


#[deriving(Clone, Eq, Hash, Show, TotalEq)]
enum Gesture {
    Rock,
    Paper,
    Scissors,
    Lizard,
    Spock,
}

#[deriving(Eq, Show)]
enum VersusResult {
    Won,
    Tie,
    Lost,
}

/// Map superior gestures to inferior ones.
fn create_superiority_map() -> HashMap<Gesture, HashSet<Gesture>> {
    let mut map: HashMap<Gesture, HashSet<Gesture>> = HashMap::new();

    map.insert(Rock,     create_gesture_set(~[Scissors, Lizard  ]));
    map.insert(Paper,    create_gesture_set(~[Rock,     Spock   ]));
    map.insert(Scissors, create_gesture_set(~[Paper,    Lizard  ]));
    map.insert(Lizard,   create_gesture_set(~[Paper,    Spock   ]));
    map.insert(Spock,    create_gesture_set(~[Rock,     Scissors]));

    map
}

fn create_gesture_set(gestures: ~[Gesture]) -> HashSet<Gesture> {
    let mut set: HashSet<Gesture> = HashSet::new();
    for gesture in gestures.iter() {
        set.insert(*gesture);
    }
    set
}

fn versus(superiority_map: HashMap<Gesture, HashSet<Gesture>>, x: Gesture, y: Gesture) -> (VersusResult, VersusResult) {
    if x == y {
        (Tie, Tie)
    } else if is_superior_to(superiority_map, x, y) {
        (Won, Lost)
    } else {
        (Lost, Won)
    }
}

/// Return `true` if the first gesture is superior to the second one.
fn is_superior_to(superiority_map: HashMap<Gesture, HashSet<Gesture>>, x: Gesture, y: Gesture) -> bool {
    superiority_map.get(&x).contains(&y)
}

#[test]
fn test_versus() {
    let arg_groups = ~[
        (Rock,     Rock,     (Tie,  Tie )),
        (Rock,     Paper,    (Lost, Won )),
        (Rock,     Scissors, (Won,  Lost)),
        (Rock,     Lizard,   (Won,  Lost)),
        (Rock,     Spock,    (Lost, Won )),
        (Paper,    Rock,     (Won,  Lost)),
        (Paper,    Paper,    (Tie,  Tie )),
        (Paper,    Scissors, (Lost, Won )),
        (Paper,    Lizard,   (Lost, Won )),
        (Paper,    Spock,    (Won,  Lost)),
        (Scissors, Rock,     (Lost, Won )),
        (Scissors, Paper,    (Won,  Lost)),
        (Scissors, Scissors, (Tie,  Tie )),
        (Scissors, Lizard,   (Won,  Lost)),
        (Scissors, Spock,    (Lost, Won )),
        (Lizard,   Rock,     (Lost, Won )),
        (Lizard,   Paper,    (Won,  Lost)),
        (Lizard,   Scissors, (Lost, Won )),
        (Lizard,   Lizard,   (Tie,  Tie )),
        (Lizard,   Spock,    (Won,  Lost)),
        (Spock,    Rock,     (Won,  Lost)),
        (Spock,    Paper,    (Lost, Won )),
        (Spock,    Scissors, (Won,  Lost)),
        (Spock,    Lizard,   (Lost, Won )),
        (Spock,    Spock,    (Tie,  Tie )),
    ];

    let superiority_map = create_superiority_map();

    for arg_group in arg_groups.iter() {
        let (x, y, expected) = *arg_group;
        let actual = versus(superiority_map.clone(), x, y);
        assert_eq!(actual, expected);
    }
}
