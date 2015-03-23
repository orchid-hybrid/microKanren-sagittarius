(import (scheme base)
        (test-check)

        (miruKanren diseq))

(test-check "=/= #1"
            (run* (lambda (q) (=/= 'x 'x)))
            '())

(test-check "=/= #2"
            (run* (lambda (q) (=/= q 'x)))
            '((_.0 where (or (=/= _.0 x)))))

(test-check "=/= #3"
            (run* (lambda (q)
                    (fresh ()
                      (=/= q 'x)
                      (== q 'x))))
            '())

(test-check "=/= #4"
            (run* (lambda (q)
                    (fresh ()
                      (== q 'x)
                      (=/= q 'x))))
            '())

(test-check "=/= #5"
            (run* (lambda (q)
                    (fresh ()
                      (== q 'x)
                      (=/= q 'y))))
            '((x where)))

(test-check "=/= #6"
            (run* (lambda (q)
                    (fresh ()
                      (=/= q 'y)
                      (== q 'x))))
            '((x where)))

(test-check "=/= #7"
            (run* (lambda (q)
                    (fresh ()
                      (=/= q 'y)
                      (== q 'x)
                      (== q 'x))))
            '((x where)))

(test-check "=/= #8"
            (run* (lambda (q)
                    (fresh (x y u v)
                      (=/= (cons x y) (cons u v))
                      (== x 'e)
                      (== u 'e))))
            '((_.0 where (or (=/= _.1 _.2)))))

