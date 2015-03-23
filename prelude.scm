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
