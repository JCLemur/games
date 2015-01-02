Project Euler
=============

Solutions to the problems presented by `Project Euler`_
implemented in different programming languages.

.. _Project Euler: https://projecteuler.net/


Spoiler Alert
-------------

Be aware that many of the implementations are accompanied by
unit tests which include the actual answers to the problems.

Don't spoil the fun and learning experience for yourself by
looking at those answers unless you have solved the respective
problem yourself.


Languages
---------

Currently problems have been implemented using these
programming languages:

- `Haskell <http://www.haskell.org/>`_ (``*.hs``)
- `Julia <http://julialang.org/>`_ (``*.jl``)
- `Nim <http://nim-lang.org/>`_ (``*.nim``)
- `Python <http://www.python.org/>`_ (``*.py``)
- `Rust <http://www.rust-lang.org/>`_ (``*.rs``)


Dependencies
------------

Implementations may require additional software to be installed:

- Haskell code uses HUnit_ for unit tests.
- Julia code might use additional packages. Install those on
  the Julia prompt, e. g. the Iterators package::

    julia> Pkg.add("Interators")

.. _HUnit: http://hunit.sourceforge.net/


Execution
---------


Nim
~~~

Nim code can be compiled and run in one go:

.. code:: sh

  $ nim c -r example.nim


Rust
~~~~

Rust code must be compiled before being executed.

To compile and run (i.e. execute the ``main`` function of)
``example.rs``:

.. code:: sh

  $ rustc example.rs && ./example

To compile ``example.rs`` and run its test functions
(insignificant warnings about the ``main`` function being
unused may appear):

.. code:: sh

  $ rustc --test example.rs && ./example
