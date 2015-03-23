(import (scheme base)
        (test-check)

        (miruKanren basic))

(include "prelude.scm")

(test-check "membero #1"
            (run* (lambda (q)
                    (membero q '(a b c))))
            '((a where)
              (b where)
              (c where)))

(test-check "membero #2"
            (run* (lambda (q)
                    (fresh ()
                      (membero q '(a b c x y z))
                      (membero q '(y b w a a w c)))))
            '((a where)
              (a where)
              (b where)
              (c where)
              (y where)))

(test-check "appendo #1"
            (run* (lambda (q)
                    (fresh (x y)
                      (== q `(,x ,y))
                      (appendo x y '(a b c)))))
            '(((() (a b c)) where)
              (((a) (b c)) where)
              (((a b) (c)) where)
              (((a b c) ()) where)))
            
