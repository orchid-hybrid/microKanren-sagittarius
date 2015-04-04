(define membero
  (lambda (x l)
    (conde
     ((fresh (d)
        (== (cons x d) l)))
     ((fresh (a d)
        (== (cons a d) l)
        (membero x d))))))

(define appendo
  (lambda (l s out)
    (conde
     ((== '() l) (== s out))
     ((fresh (a d res)
        (== `(,a . ,d) l)
        (== `(,a . ,res) out)
        (appendo d s res))))))

(define (eacho p l)
  (conde
   ((== l '()))
   ((fresh (l-car l-cdr)
      (== l `(,l-car . ,l-cdr))
      (p l-car)
      (eacho p l-cdr)))))

(define (mapo f l fl)
  (conde
   ((== l '()) (== fl '()))
   ((fresh (l-car l-cdr
                  fl-car fl-cdr)
      (== l `(,l-car . ,l-cdr))
      (== fl `(,fl-car . ,fl-cdr))
      (f l-car fl-car)
      (mapo f l-cdr fl-cdr)))))

