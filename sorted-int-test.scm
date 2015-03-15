(import (scheme base)
        (scheme write)
        (sorted-int-set))

(display (intersects? '(1 2 3 4 5)
                      '(3)))

(display (intersects? '(1 2 3 4 5 21 22 23 24 25 41 42 43 44 45)
                      '(11 12 13 14 15 31 32 33 34 35 51 52 53 54 55)))

(display (intersects? '(1 2 3 4 5 21 22 23 24 25 33 41 42 43 44 45)
                      '(11 12 13 14 15 31 32 33 34 35 51 52 53 54 55)))

;; #t#f#t
