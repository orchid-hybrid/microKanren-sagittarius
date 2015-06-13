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



(define (edge x y)
  (define (edge* x y)
    (membero (cons x y) '((a . b)
			  (b . c)
			  (c . a))))
  (conde ((edge* x y)) ((edge* y x))))

(define (reach x y)
  (conde ((== x y))
	 ((fresh (m)
	    (edge x m)
	    (reach m y)))))


(define (reach* x y)
  (conde ((== x y))
	 ((fresh (m)
	    (edge x m)
	    (table-membero reach-table (cons m y))))))

(define (reach*1 xy)
  (fresh (x y) (== xy (cons x y)) (reach* x y)))

(define reach-table (make-table reach*1))

