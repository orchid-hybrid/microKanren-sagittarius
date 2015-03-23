(define-library (miruKanren monad)

  (import (scheme base))

  (export mzero
          mplus

          unit
          bind
          
          mapm)

  (include "monad.scm"))

