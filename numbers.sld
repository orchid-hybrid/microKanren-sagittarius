;; number relations based on "oleg numbers"
(define-library (miniNumbers)

  (import (scheme base)
          (scheme read)
          (scheme write)
          (miniKanren))

  (export zeroo poso >1o
          full-addero
          addero
          gen-addero
          pluso minuso
          *o odd-*o bound-*o
          =lo <lo <=lo 
          <o <=o
          /o
          splito
          logo
          exp2
          repeated-mul
          expo)

  (include "numbers.scm"))
