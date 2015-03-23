# What is this?

This is a minikanren implementation. It grew out of the code accompanying the microKanren paper. It's been split into a lot of files to try to make it more modular and approachable.

It aims to work on all R7RS scheme implementations (that have sort). There are a few different minikanren language levels you can import:

* Basic: Just simple minikanren. fresh conde and ==
* Disequality: Basic extended with disequality =/=



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
