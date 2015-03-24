(define (== u v)
  (lambda (k)
    (let-values (((s p) (unify/prefix u v (substitution k))))
      (if s
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
             (else (error "not even")))
       k))))

(define (symbolo x) (fresh (t) (typeo x t) (== t 'symbol)))
(define (numbero x) (fresh (t) (typeo x t) (== t 'number)))
(define (booleano x) (fresh (t) (typeo x t) (== t 'boolean)))
(define (nullo x) (fresh (t) (typeo x t) (== t 'null)))
(define (pairo x) (fresh (t) (typeo x t) (== t 'pair)))

(define (not-symbolo x) (fresh (t) (typeo x t) (=/= t 'symbol)))
(define (not-numbero x) (fresh (t) (typeo x t) (=/= t 'number)))
(define (not-booleano x) (fresh (t) (typeo x t) (=/= t 'boolean)))
(define (not-nullo x) (fresh (t) (typeo x t) (=/= t 'null)))
(define (not-pairo x) (fresh (t) (typeo x t) (=/= t 'pair)))
