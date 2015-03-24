(define (== u v)
  (lambda (k)
    (let-values (((s p) (unify/prefix u v (substitution k))))
      (if s
          ;; For unification with disequality and a type store
          ;; we normalize the disequality store and then
          ;; normalize the type store. After normalizing the
          ;; type store you may have to perform some extra
          ;; unification (to associate type variables with
          ;; each other) - we avoid an infinite loop by checking
          ;; if it's null.
	  (bind (normalize-disequality-store
                 (modified-substitution (lambda (_) s) k))
                (lambda (k)
                  (let-values (((k u-left u-right)
                                (normalize-type-store p k)))
                    (if (null? u-left)
                        (unit k)
                        ((== u-left u-right) k)))))
	  mzero))))

(define (typeo x t)
  (lambda (k)
    (let ((x (walk x (substitution k))))
      ((cond ((var? x) (call/type-of-var x k
                         (lambda (t-var) (== t t-var))))
             ((type? x) => (lambda (type-name) (== t type-name)))
             (else (error "not valid minikanren term in typeo")))
       k))))

(define (symbolo x) (typeo x 'symbol))
(define (numbero x) (typeo x 'number))
(define (booleano x) (typeo x 'boolean))
(define (nullo x) (typeo x 'null))
(define (pairo x) (typeo x 'pair))

(define (not-symbolo x) (fresh (t) (typeo x t) (=/= t 'symbol)))
(define (not-numbero x) (fresh (t) (typeo x t) (=/= t 'number)))
(define (not-booleano x) (fresh (t) (typeo x t) (=/= t 'boolean)))
(define (not-nullo x) (fresh (t) (typeo x t) (=/= t 'null)))
(define (not-pairo x) (fresh (t) (typeo x t) (=/= t 'pair)))
