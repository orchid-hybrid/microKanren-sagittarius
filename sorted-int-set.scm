(define (intersects? key1 s1 key2 s2)
  (cond ((null? s1) #f)
        ((null? s2) #f)
        (else
         (let ((x (key1 (car s1)))
               (y (key2 (car s2))))
           (cond ((< x y) (intersects? key1 (cdr s1) key2 s2))
                 ((= x y) #t)
                 ((> x y) (intersects? key1 s1 key2 (cdr s2))))))))

