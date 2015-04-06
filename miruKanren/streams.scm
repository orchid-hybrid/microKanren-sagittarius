;; A stream is one of
;;  * nil
;;  * a pair whose cdr is a stream
;;  * a zero arg lambda 'delaying' a pair or nil
;;    (can't delay twice!)

(define (pull $)
  (if (procedure? $) (pull ($)) $))

(define (stream-map f s)
  (cond ((null? s) s)
	((pair? s) (cons (f (car s)) (stream-map f (cdr s))))
	((procedure? s)
	 (lambda ()
	   (stream-map f (s))))))

(define (stream-take n s)
  (if (= n 0)
      '()
      (cond ((null? s) s)
	    ((pair? s) (cons (car s) (stream-take (- n 1) (cdr s))))
	    ((procedure? s)
	     (lambda ()
	       (stream-take n (s)))))))

(define (take n $)
  (if (zero? n)
      '()
      (let (($ (pull $)))
	(if (null? $) '() (cons (car $) (take (- n 1) (cdr $)))))))

(define (take-all $)
  (let (($ (pull $)))
    (if (null? $)
        '()
        (cons (car $) (take-all (cdr $))))))
