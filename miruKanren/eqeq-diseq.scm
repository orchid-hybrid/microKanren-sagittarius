(define (== u v)
  (lambda (k)
    (let (((s p) (unify/prefix u v (substitution k))))
      (if s
	  (normalize-disequality-store
           (modified-substitution (lambda (_) s) k))
	  mzero))))

(define (=/= u v)
  (lambda (k)
    (let ((d^ (disequality u v (substitution k))))
      (if d^
          (unit (modified-disequality-store (cons d^ (disequality-store k)) k))
          mzero)
