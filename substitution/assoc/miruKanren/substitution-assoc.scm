(define (substitution-get k s)
  (cond
   ((assoc k s) => (lambda (p) (values #t (cdr p))))
   (else (values #f #f))))

(define (substitution-set k v s)
  (cons (cons k v) s))

(define substitution-size length)

(define empty-substitution '())
