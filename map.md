# kanren ()
holds counter/substitution/constraints/etc.

# variables ()
the variable representation

# streams ()
operations on infinite/lazy streams

# utils ()
just some list functions

# sorted-int-set ()
represents a set as a sorted list of integers
lets you do intersection/intersect test quickly

# unification (utils variables)
implements walk, occurs check, unification
(but not the == goal)

# monad (kanren)
implements the minikanren monad with fair search
threading the kanren state

# micro (kanren variables monad)
The basic microkanren operators (call/fresh, disj, conj)

# mini (micro)
The macros for minikanren operators in terms of microkanren

# reification (variables unification kanren)
turning the implementations represented terms into something readable

# run (streams reification)
The harness to actually run queries/extract results from streams

# eqeq (kanren monad unification)
This is the most basic == implementation
no extra stuff

# basic (mini run eqeq)
This gives you the basic minikanren language with a single import
