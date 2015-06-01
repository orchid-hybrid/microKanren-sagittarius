
(define (binary-inc b)
  (if (null? b)
      '(#t)
      (if (car b)
	  (cons #f (binary-inc (cdr b)))
	  (cons #t (cdr b)))))

;; > (binary-inc '())
;; '(#t)
;; > (binary-inc '(#t))
;; '(#f #t)
;; > (binary-inc '(#f #t))
;; '(#t #t)
;; > (binary-inc '(#t #t))
;; '(#f #f #t)
;; > (binary-inc '(#f #f #t))
;; '(#t #f #t)
;; > (binary-inc '(#t #f #t))
;; '(#f #t #t)
;; > (binary-inc '(#f #t #t))
;; '(#t #t #t)
;; > (binary-inc '(#t #t #t))
;; '(#f #f #f #t)

;; We should probably use machine integers for this instead of a list

(define (next-bit n)
  (values
   (= 1 (remainder n 2))
   (quotient n 2)))
