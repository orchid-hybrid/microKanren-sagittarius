(import (scheme base)
        (scheme write)
        (test-check)

        (larceny benchmarking)
        (examples numbers)
        (miruKanren mk-basic))

(display (time (begin (run* (lambda (q)
                              (fresh (x y)
                                (== q `(,x ,y))
                                (*o x y (build-num 420)))))
                      '())))
