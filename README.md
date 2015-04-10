# What is this?

This is a minikanren implementation. It grew out of the code accompanying the microKanren paper and lessons from Willam Byrd. It's been split into a lot of files to try to make it more modular and approachable.

It aims to work on all R7RS scheme implementations. There are a few different minikanren language levels you can import:

* mk-basic: Just simple minikanren - like the reasoned schemer. fresh conde and ==
* mk-diseq: Basic extended with disequality =/= constraints
* mk-types: diseq + typeo constraint that lets us have disjoint types like symbolo, booleano, pairo as well as negations like not-symbolo
* mk-watch: This is simple minikanren extended with watched variables (watching until they become ground then triggering a goal) - this is good for bijection constraints.
* mk-table: This was a (failed) experiment to add tabling based on the idea of replacing a relation with looking up a lazy stream of results - it doesn't cut off infinities like real tabling though, and can cause infinite loops and computer to crash.

The unifier itself can also be swapped out. It would be nice to try different implementations such as binary trees, union find based unification... Since R7RS scheme doesn't have functors we have to do this in a convoluted way selecting the 'path' of the unification implementation you want to use: We make directories unification/basic and unification/records and put the slds in there. larceny is okay with this but sagittarius and chicken require a symbolic link to the source in there too.

* unification/basic: this is just the plain unification. You can use this with any language level.
* unification/records: this lets you do some programming that would otherwise require absento constraints. You can only use this with mk-basic, diseq and types

# How to get a repl or run a file?

To run in larceny:
```
rlwrap larceny -r7rs -path .:unification/basic
rlwrap larceny -r7rs -path .:unification/records
rlwrap larceny -r7rs -path .:unification/basic -program t/t1.scm
```

To run in sagittarius:
```
rlwrap sagittarius -c -L. -Lunification/basic -S.sld
rlwrap sagittarius -c -L. -Lunification/basic -S.sld t/t1.scm
```

To run in chicken: Need r7rs egg.

We have to create a file chicken.scm that includes all the sld files. Start with:
```
find . -name '*.sld' | sed -e 's/^.\//\(include "/' | sed -e 's/$/")/' > chicken-basic.scm
```

then find a dependency ordering manually that the compiler accepts. The utility program chicken-r7rs-sld-topsort.scm can do this for you.

```
csi -require-extension r7rs chicken-basic.scm
csi -require-extension r7rs chicken-basic.scm t/t1.scm -e '(exit)'
```

To run in racket:

I've written a script racket-module-maker.rkt that transforms the .sld files in miruKanren/ into .rkt module definitions which include the scheme source code in there. You shouldn't need to run this script unless you are working on the code.

* cd racket
* drracket miruKanren/mk-basic.rkt (or mk-diseq)
* then you should be able to paste minikanren run queries into the REPL
