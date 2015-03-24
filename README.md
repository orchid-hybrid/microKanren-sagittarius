# What is this?

This is a minikanren implementation. It grew out of the code accompanying the microKanren paper and lessons from Willam Byrd. It's been split into a lot of files to try to make it more modular and approachable.

It aims to work on all R7RS scheme implementations (that have sort). There are a few different minikanren language levels you can import:

* mk-basic: Just simple minikanren - like the reasoned schemer. fresh conde and ==
* mk-diseq: Basic extended with disequality =/= constraints
* mk-types: diseq + typeo constraint that lets us have disjoint types like symbolo, booleano, pairo as well as negations like not-symbolo
* mk-watch: This is simple minikanren extended with watched variables (watching until they become ground then triggering a goal) - this is good for bijection constraints.

# How to get a repl or run a file?

To run in larceny:
```
rlwrap larceny -r7rs -path .
rlwrap larceny -r7rs -path . -program t/t1.scm
```

To run in sagittarius:
```
rlwrap sagittarius -c -L. -S.sld
rlwrap sagittarius -c -L. -S.sld t/t1.scm
```
