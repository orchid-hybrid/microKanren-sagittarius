(define-library (miruKanren bijections)
  
  (import (scheme base))
  
  (export number->peano
          peano->number
          
          number->binary
          binary->number)
  
  (include "bijections.scm"))
