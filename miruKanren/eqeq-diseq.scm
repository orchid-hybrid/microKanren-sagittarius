(define (== u v)
  (lambda (k)
    (let-values (((s p) (unify/prefix u v (substitution k))))
      (if s
	  (normalize-disequality-store
           (modified-substitution (lambda (_) s) k))
	  mzero))))

(define (=/= u v)
  (lambda (k)
    (let ((d^ (disequality u v (substitution k))))
      (if d^
          (if (null? d^)
              (unit k)
              (unit (modified-disequality-store
                     (lambda (_)
                       (cons d^ (disequality-store k)))
                     k)))
          mzero))))
