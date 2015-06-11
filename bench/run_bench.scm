(import (scheme base)
        (scheme write)
        (test-check)
        (larceny benchmarking)
        
        (bench numbers)
        (bench append))

(for-each
 (lambda (b)
   (newline)
   (display "--------------------")
   (newline)
   (display "  ") (display (car b))
   (newline)
   (display "--------------------")
   (newline)
   (time ((cdr b))))
`((numbers . ,numbers-bench) (append . ,append-bench)))
