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
- `Python <http://www.python.org/>`_ (``*.py``)


Dependencies
------------

Implementations may require additional software to be installed:

- Haskell code uses HUnit_ for unit tests.
- Julia code might use additional packages. Install those on
  the Julia prompt, e. g. the Iterators package::

    julia> Pkg.add("Interators")

.. _HUnit: http://hunit.sourceforge.net/
