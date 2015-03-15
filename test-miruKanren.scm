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

'(display (run* (lambda (q)
                 (fresh (x y)
                   (== q `(,x ,y))
                   (appendo x y '(a b c))))))

(define (print s) (display s) (newline))
(print (run* (lambda (q) (fresh () (== q 'x) (symbolo q)))))
(print (run* (lambda (q) (fresh () (== q '(x)) (symbolo q)))))
(print (run* (lambda (q) (fresh () (symbolo q) (== q 'x)))))
(print (run* (lambda (q) (fresh () (symbolo q) (== q '(x))))))
(print (run* (lambda (q) (fresh () (symbolo q) (fresh (w) (== q w))))))
(print (run* (lambda (q) (fresh () (symbolo q) (fresh (w) (== q w) (== w 'x))))))
(print (run* (lambda (q) (fresh () (symbolo q) (fresh (w) (== q w) (== w '(x)))))))
(print (run* (lambda (q) (fresh () (symbolo q) (fresh (w) (== w q) (== w 'x))))))
(print (run* (lambda (q) (fresh () (symbolo q) (fresh (w) (== w q) (== w '(x)))))))
