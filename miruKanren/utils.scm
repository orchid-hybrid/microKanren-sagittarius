(define (assp p l)
  (if (null? l)
      #f
      (if (p (caar l))
	  (car l)
	  (assp p (cdr l)))))

(define (filter p l)
  (if (null? l)
      '()
      (if (p (car l))
	  (cons (car l) (filter p (cdr l)))
	  (filter p (cdr l)))))

(define (concat-map f l)
  (apply append (map f l)))
