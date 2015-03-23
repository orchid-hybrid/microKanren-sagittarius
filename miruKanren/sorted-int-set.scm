;; A set is represented by a sorted list of increasing integers

(define (intersects? key s1 s2)
  (cond ((null? s1) #f)
        ((null? s2) #f)
        (else
         (let ((x (key (car s1)))
               (y (key (car s2))))
           (cond ((< x y) (intersects? key (cdr s1) s2))
                 ((= x y) #t)
                 ((> x y) (intersects? key s1 (cdr s2))))))))

(define (intersection key s1 s2)
  (cond ((null? s1) '())
        ((null? s2) '())
        (else
         (let ((x (key (car s1)))
               (y (key (car s2))))
           (cond ((< x y) (intersection key (cdr s1) s2))
                 ((= x y) (cons (car s1) (intersection key (cdr s1) (cdr s2))))
                 ((> x y) (intersection key s1 (cdr s2))))))))
