(import (scheme base)
        (test-check)

        (miruKanren mk-watch))

(test-check "peanoo #1"
            (run* (lambda (q)
                    (fresh ()
                      (peanoo 4 q))))
            '(((s (s (s (s z)))) where)))

(test-check "binaryo #2"
            (run* (lambda (q)
                    (fresh ()
                      (binaryo 8 5 q))))
            '(((0 0 0 0 0 1 0 1) where)))
