(import (scheme base)
	(scheme write)
        (test-check)

        (miruKanren mk-watch))

(include "examples/dpll.scm")

;; http://www.onlinespiele-sammlung.de/mastermind/mastermindgames/lundy/

(define (concat-map f l) (apply append (map f l)))

(define (setup f cols vars)
  (fresh (black1 blue1 yellow1 green1 red1 orange1
	  black2 blue2 yellow2 green2 red2 orange2
	  black3 blue3 yellow3 green3 red3 orange3
	  black4 blue4 yellow4 green4 red4 orange4)
    (let ((col1 (list black1 blue1 yellow1 green1 red1 orange1))
	  (col2 (list black2 blue2 yellow2 green2 red2 orange2))
	  (col3 (list black3 blue3 yellow3 green3 red3 orange3))
	  (col4 (list black4 blue4 yellow4 green4 red4 orange4)))
      (fresh ()
	(== vars (append col1 col2 col3 col4))
	(== cols (list col1 col2 col3 col4))
	(== f (concat-map setup-column (list col1 col2 col3 col4)))))))

(define (setup-column colors)
  (cons
   ;; it must have color[s]
   (map (lambda (color)
	  `(#t . ,color)) colors)
   
   ;; out of each pair of colors, at least one is wrong
   (concat-map
    (lambda (color-1)
      (concat-map
       (lambda (color-2)
	 (if (eq? color-1 color-2)
	     (list)
	     (list (list `(#f . ,color-1)
			 `(#f . ,color-2))))) colors)) colors)))

(define (read-result c r)
  (conde
   ((== c '(#t #f #f #f #f #f)) (== r 'black))
   ((== c '(#f #t #f #f #f #f)) (== r 'blue))
   ((== c '(#f #f #t #f #f #f)) (== r 'yellow))
   ((== c '(#f #f #f #t #f #f)) (== r 'green))
   ((== c '(#f #f #f #f #t #f)) (== r 'red))
   ((== c '(#f #f #f #f #f #t)) (== r 'orange))))

;; You get one small black peg for a guess of the right colour in the right location and one small white peg for a guess of of the right colour but in the wrong position



(define (go)
  (run^ 1 (lambda (q) (fresh (f c v)
			(setup f c v)
			(sat f v)
			(mapo read-result c q)))))

(write (go))
