;; Converting numerals to peano numbers
;;
;; peano numbers are
;;   z
;;   (s z)
;;   (s (s z))
;;   (s (s (s z)))
;;   ...

;; https://github.com/webyrd/peano-challenge/blob/master/peano.scm
(define (number->peano n)
  (if (= 0 n)
      'z
      `(s ,(number->peano (- n 1)))))

(define (peano->number n)
  (cond ((eq? n 'z) 0)
        ((and (list? n)
              (= 2 (length n))
              (eq? 's (car n)))
         (+ (peano->number (cadr n)) 1))
    (else (error "not a number in peano->number" n))))


;; Converting numerals to binary (lists of bits)
;;
;; converting to binary also takes the number of bits
;; so that we can pad it up to that with zeros
;;
;; lsb/msb direction?

(define (number->binary-aux len n m)
  (cond
   ((odd? n)
    (number->binary-aux (- len 1) (quotient (- n 1) 2) (cons 1 m)))
   ((and (not (zero? n)) (even? n))
    (number->binary-aux (- len 1) (quotient n 2) (cons 0 m)))
   ((zero? n) (values len m))))

(define (number->binary len)
  (lambda (n)
    (if (number? n)
	(let-values (((len b) (number->binary-aux len n '())))
	  (if (>= len 0)
	      (append (make-list len 0) b)
	      #f))
	#f)))

(define (binary->number* b)
  (if (null? b)
      0
      (+ (car b)
         (* 2 (binary->number* (cdr b))))))

(define (binary->number b)
  (binary->number* (reverse b)))
