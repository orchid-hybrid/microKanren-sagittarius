;; Variable representation is a vector of a single int
;; it's useful to have an ordering to speed up some set operations

(define (var c) (vector c))
(define (var? x) (vector? x))
(define (var=? x1 x2) (= (vector-ref x1 0) (vector-ref x2 0)))
(define (var< i j) (< (vector-ref i 0) (vector-ref j 0)))
(define (var->int v) (vector-ref v 0))
