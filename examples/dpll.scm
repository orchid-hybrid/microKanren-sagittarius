
'(import (scheme base)
        (test-check)

        (miruKanren mk-watch))

(include "prelude.scm")

;; This is a port of: staff.city.ac.uk/~jacob/solver/flops.pdf
;; to minikanren

(define (booleano b)
  (conde ((== b #t))
	 ((== b #f))))

(define (noto x y)
  (conde ((== x #t) (== y #f))
	 ((== x #f) (== y #t))))

(define (sat clauses vars)
  (fresh ()
    (eacho clause-setup clauses)
    (eacho booleano vars)))

(define (clause-setup clause)
  (fresh (pol var pairs)
    (== clause `((,pol . ,var) . ,pairs))
    (set-watch pairs var pol)))

(define (set-watch pairs var1 pol1)
  (fresh (var2 pol2 pairs*)
    (conde ((== pairs '())
	    (== var1 pol1))
	   ((== pairs `((,pol2 . ,var2) . ,pairs*))
	    (watch var1 (update-watch pol1 var2 pol2 pairs*))
	    (watch var2 (update-watch pol2 var1 pol1 pairs*))))))

(define (update-watch pol1 var2 pol2 pairs)
  (lambda (var1)
    (conde ((== var1 pol1))
	   ((noto var1 pol1) (set-watch pairs var2 pol2)))))

;;;;;;;;;;;;;;

;; wikipedia example
;; "(x1 \/ ~x2) /\ (~x1 \/ x2 \/ x3) /\ ~x1" is a formula in conjunctive normal form

(define (f1 formula vars)
  (fresh (x1 x2 x3)
    (== vars `(,x1 ,x2 ,x3))
    (== formula
	`(((#t . ,x1) (#f . ,x2))
	  ((#f . ,x2) (#t . ,x2) (#t . ,x3))
	  ((#f . ,x1))
	  ))))

;; (include "examples/dpll.scm")
;; (run^ 1 (lambda (q) (fresh (v) (f1 q v) (sat q v))))



;; Knuth examples

(define (f2a formula vars)
  (fresh (x1 x2 x3)
    (== vars `(,x1 ,x2 ,x3))
    (== formula
	`(((#t . ,x1) (#f . ,x2))
	  ((#t . ,x2) (#t . ,x3))
	  ((#f . ,x1) (#f . ,x3))
	  ((#f . ,x1) (#f . ,x2) (#t . ,x3))
	  ))))

(define (f2b formula vars)
  (fresh (x1 x2 x3 formula*)
    (f2a vars formula*)
    (== vars `(,x1 ,x2 ,x3))
    (== formula
	`(((#t . ,x1) (#t . ,x2) (#f . ,x3))
	  . ,formula*
	  ))))


;; > (run^ 1 (lambda (q) (fresh (v) (f2a q v) (sat q v))))
;; (((((#t . #f) (#f . #f))
;;    ((#t . #f) (#t . #t))
;;    ((#f . #f) (#f . #t))
;;    ((#f . #f) (#f . #f) (#t . #t)))
;;   where))

;; > (run^ 1 (lambda (q) (fresh (v) (f2b q v) (sat q v))))
;; ()

