(define-library (miruKanren eqeq-diseq)

  (import (scheme base)
          (miruKanren kanren)
          (miruKanren monad)
          (miruKanren unification)
          (miruKanren disequality))

  (export == =/=)

  (include "eqeq-diseq.scm"))
