(define-library (miruKanren eqeq)

  (import (scheme base)
          (miruKanren kanren)
          (miruKanren monad)
          (miruKanren unification))

  (export ==)

  (include "eqeq.scm"))
