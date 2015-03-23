(define-library (miruKanren sorted-int-set)

  (import (scheme base))

  (export intersects?
          intersection)
  
  (include "sorted-int-set.scm"))
