(import (scheme base)
        (scheme write)
        (miruKanren))

;; larceny -r7rs -path . -program test-miruKanren.scm

(define (appendo l s out)
  (conde
    ((== '() l) (== s out))
    ((fresh (a d res)
       (== `(,a . ,d) l)
       (== `(,a . ,res) out)
       (appendo d s res)))))

(run* (lambda (q)
        (fresh (x y)
          (== q `(,x ,y))
          (appendo x y '(a b c)))))
