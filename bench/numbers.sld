(define-library (bench numbers)

(import (scheme base)
        (examples numbers)
        (miruKanren mk-basic))

(export numbers-bench)

(begin

  (define (numbers-bench)
    (run* (lambda (q)
            (fresh (x y)
              (== q `(,x ,y))
              (*o x y (build-num 420))))))
))
