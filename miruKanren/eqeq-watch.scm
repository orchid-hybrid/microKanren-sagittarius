(define (== u v)
  (lambda (k)
    (let-values (((s p) (unify/prefix u v (substitution k))))
      (if s
          (normalize-surveillance p (modified-substitution (lambda (_) s) k))
	  mzero))))

(define (watch x g)
  ;; waits for x to become fully ground. then executes the
  ;; goal with its ground form.
  ;;
  ;; To implement this we then take a list of all variables
  ;; inside the term x. If there are zero then it is ground
  ;; so trigger g. Otherwise add those variables to a watch
  ;; list
  ;;
  (lambda (k)
    (let ((vs (variables-in-term (substitution k) x))
          (g* (lambda (k)
                (let ((x* (walk* x (substitution k))))
                  ((g x*) k)))))
      (if (null? vs)
          (g* k)
          (unit (make-kanren (counter k)
                             (substitution k)
                             (cons (cons (sort vs var<) g*)
                                   (surveillance k))))))))

(define (bijectiono f g x y)
  (fresh ()
    (watch x (lambda (x) (== y (f x))))
    (watch y (lambda (y) (== (g y) x)))))

(define (peanoo x y)
  (bijectiono number->peano peano->number
              x y))

(define (binaryo digits n b)
  (bijectiono (number->binary digits)
              binary->number
              n b))
