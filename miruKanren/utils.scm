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

(define (any p l)
  (if (null? l)
      #f
      (or (p (car l)) (any p (cdr l)))))

(define (concat-map f l)
  (apply append (map f l)))

(define (type? x)
  (cond ((symbol? x) 'symbol)
        ((number? x) 'number)
        ((boolean? x) 'boolean)
        ((null? x) 'null)
        ((pair? x) 'pair)
	((record? x) => (lambda (n/c/d) (car n/c/d)))
        (else #t)))
