(define substitution-not-found (list 'empty-substitution))

(define empty-substitution '())

(define (substitution-lookup v s)
  (if (null? s)
      substitution-not-found
      (if (= v (caar s))
	  (cdar s)
	  (substitution-lookup v (cdr s)))))

(define (substitution-update k v s)
  `((,k . ,v) . ,s))

(define substitution-size length)
