(import (scheme base)
        (test-check)

        (miruKanren mk-basic)
	(miruKanren table))

(include "prelude.scm")

(define (ao l)
  (fresh (x y z)
    (== l (list x y z))
    (appendo x y z)))

(define t (make-table ao))

(define (ao* x y z)
  (fresh (l)
    (== l (list x y z))
    (table-membero t l)))

