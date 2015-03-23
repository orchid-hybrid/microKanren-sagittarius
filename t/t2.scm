(import (scheme base)
        (test-check)

        (miruKanren micro)
        (miruKanren mini)
        (miruKanren run)
        (miruKanren eqeq))

(test-check "== #1"
            (run* (lambda (q)
                    (== q 'yes)))
            '((yes where)))

(test-check "== #2"
            (run* (lambda (q)
                    (fresh ()
                      (== q 'yes)
                      (== q 'no))))
            '())

(test-check "== #3"
            (run* (lambda (q)
                    (fresh (x y)
                      (== q (cons x y))
                      (== x 'yes)
                      (== y 'no))))
            '(((yes . no) where)))

(test-check "==/occurs-check #4"
            (run* (lambda (q)
                    (== q (cons q q))))
            '())

(test-check "==/conde #1"
            (run* (lambda (q)
                    (conde
                     ((== q 'yes))
                     ((== q 'no)))))
            '((yes where)
              (no where)))

(test-check "==/conde #2"
            (run* (lambda (q)
                    (fresh (x y)
                      (== q (cons x y))
                      (conde
                       ((== x 'yes))
                       ((== x 'no)))
                      (conde
                       ((== y 'foo))
                       ((== y 'bar))))))
            '(((yes . foo) where)
              ((yes . bar) where)
              ((no . foo) where)
              ((no . bar) where)))
