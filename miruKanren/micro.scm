(define (1+ n) (+ 1 n))

(define (call/fresh f)
  (lambda (k)
    ((f (var (counter k))) (modified-counter 1+ k))))

(define (disj g1 g2) (lambda (k) (mplus (g1 k) (g2 k))))
(define (conj g1 g2) (lambda (k) (bind (g1 k) g2)))
