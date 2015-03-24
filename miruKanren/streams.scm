;; A stream is one of
;;  * nil
;;  * a pair whose cdr is a stream
;;  * a zero arg lambda 'delaying' a pair or nil
;;    (can't delay twice!)

(define (pull $)
  (if (procedure? $) (pull ($)) $))

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
