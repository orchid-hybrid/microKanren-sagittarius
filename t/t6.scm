(import (scheme base)
        (test-check)

        (miruKanren mk-watch))

(test-check "peanoo #1"
            (run* (lambda (q)
                    (fresh ()
                      (peanoo 4 q))))
            '(((s (s (s (s z)))) where)))
