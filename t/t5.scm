(import (scheme base)
        (test-check)

        (miruKanren mk-types))

(include "prelude.scm")

(test-check "typeo #1"
            (run* (lambda (q)
                    (fresh ()
                      (booleano q)
                      (membero q '(a b #t y #t #f 1 2 3)))))
            '((#t where)
              (#t where)
              (#f where)))

(test-check "typeo #2"
            (run* (lambda (q)
                    (fresh ()
                      (symbolo q)
                      (membero q '(a b #t y #t #f 1 2 3)))))
            '((a where)
              (b where)
              (y where)))

(test-check "typeo #3"
            (run* (lambda (q)
                    (fresh ()
                      (numbero q)
                      (membero q '(a b #t y #t #f 1 2 3)))))
            '((1 where)
              (2 where)
              (3 where)))


(test-check "typeo #4"
            (run* (lambda (q)
                    (fresh ()
                      (not-numbero q)
                      (not-booleano q)
                      (membero q '(a b #t y #t #f 1 2 3)))))
            '((a where)
              (b where)
              (y where)))

(test-check "typeo #5"
            (run* (lambda (q)
                    (fresh ()
                      (numbero q)
                      (booleano q))))
            '())

(test-check "typeo #6"
            (run* (lambda (q) (fresh (t)
                                (typeo q t)
                                (=/= t 'symbol)
                                (typeo q 'symbol))))
            '())

(test-check "typeo #7"
            (run* (lambda (q) (fresh (t)
                                (typeo q t)
                                (typeo q 'symbol)
                                (=/= t 'symbol))))
            '())

(test-check "typeo #8"
            (run* (lambda (q)
                    (fresh ()
                      (numbero q)
                      (not-numbero q))))
            '())

(test-check "typeo #9"
            (run* (lambda (q)
                    (fresh ()
                      (numbero q)
                      (not-symbolo q))))
            '((_.0 where (_.0 : number))))
