# Disequality

The basic minikanren language has logical operations like conde, fresh variables and unification over s-expressions.

The unification operator (==) expresses that two terms are equal but it is also very useful to be able to express that two terms aren't equal: for that we'll use (=/=).

# Relationship to unification

Unification is solved by finding the most general unifier at the time (==) is used, on the other hand (=/=) may have to leave a constraint around for later. For example:

```
(fresh (x)
 (=/= x 'a)
 (do-other-stuff)
 (== x 'a))
```

minikanren will have to keep a note that x is not 'a right until the end so that the final unification can fail.

# The De-Morgan Law

Another way that disequality differs from unification is that it can introduce an OR situation, for example:

```
(fresh (x y u v)
 (=/= (cons x y)
      (cons u v)))
```

holds as long as `(or (=/= x u) (=/= y v))`.

This happens because disequality is the negation of equality and `(== (cons x y) (cons u v))` is equivalent to `(and (== x u) (== y v)) which, negated, is (or (=/= x u) (=/= y v))`

# Implementing it with unification.

The technique from Byrd [thesis] to implement `=/=` using unification itself, but interpreting it negatively. Each time this is done we get an OR of disequalities, so we will need a disequality constraint store that holds them.

# Subsumption

One thing that I haven't dealt with is subsumption. Currently the disequality constraint store can only get larger but it would be good to remove things that are subsumed by other stricter constraints. I'm not sure how to do this efficiently.

# Source

* https://github.com/orchid-hybrid/microKanren-sagittarius/blob/master/miruKanren/disequality.scm
* https://github.com/orchid-hybrid/microKanren-sagittarius/blob/master/miruKanren/eqeq-diseq.scm

# Hangouts

* https://www.youtube.com/watch?v=mMQ6On3vdvA
