;; This defines a goal for unification of two terms

(define (== u v)
  (lambda (k)
    (let ((s (unify u v (substitution k))))
      (if s
	  (unit (modified-substitution (lambda (_) s) k))
	  mzero))))
