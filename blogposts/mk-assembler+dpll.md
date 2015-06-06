# MIPS

The MIPS CPU has an extremely clean simple instruction set. Each instruction is encoded with one 32bit word.

We wanted to implement the instruction set as a relation between binary words and assembly code in minikanren. Usually it's assembler and disassembler are written as separate programs based on the same spec.

# Bijection constraints

To do this I added a new type of constraint to my minikanren implementation called bijection constraints. Here's an example:

```
(define (peanoo x y)
  (bijectiono number->peano peano->number
              x y))
```

it takes two scheme functions that convert back and forth, and it takes two objects x,y which it watches. When one of them becomes ground it converts it to the other type and unifies.

so `(peanoo 3 q)` will result in `q` being `(s (s (s z)))` for example.

We used this to build a binaryo constraint that converts from a word into a 32 bit binary string. Then wrote a minikanren relation that works on patterns of bit strings.

# Watch/Sources

The bijectiono constraint is itself implemented using watch as you can see here:

* https://github.com/orchid-hybrid/microKanren-sagittarius/blob/master/miruKanren/eqeq-watch.scm

watch maintains a list of all the fresh variables inside a term and once that list is empty it knows the term is fully ground so triggers a minikanren goal.

The watch constraint itself was useful in porting the DPLL sat solver pearl from prolog to minikanren:

* https://github.com/orchid-hybrid/microKanren-sagittarius/blob/master/examples/dpll.scm

The implementation of watch is here:

* https://github.com/orchid-hybrid/microKanren-sagittarius/blob/master/miruKanren/surveillance.scm
