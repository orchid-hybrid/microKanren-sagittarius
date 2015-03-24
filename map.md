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

# disequality (utils kanren monad unification)
This implements all the disequality-store management along with the =/= goal/constraint

# eqeq-diseq (kanren monad unification disequality)
This is a slightly modified == that ensures disequalities aren't violated by normalizing the type store

# type (utils variables kanren monad micro unification disequality)
this implements the type-store management

# eqeq-typeo (utils kanren variables monad micro mini unification disequality type)
This implements the typeo constraint along with a version of ==, it also pulls in =/=

# mk-basic (mini run eqeq)
This gives you the basic minikanren language with a single import

# mk-diseq (mini run eqeq-diseq)
This gives you minikanren language with =/= constraint, with a single import

# mk-types (mini run eqeq-typeo)
This language is == and =/= along with a flexible `typeo` constraint that lets us implement disjoint types symbolo/booleano/etc along with not-symbolo (using =/=).
