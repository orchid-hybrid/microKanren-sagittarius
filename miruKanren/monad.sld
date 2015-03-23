(define-library (miruKanren monad)

  (import (scheme base))

  (export mzero
          mplus

          unit
          bind)

  (include "monad.scm"))

