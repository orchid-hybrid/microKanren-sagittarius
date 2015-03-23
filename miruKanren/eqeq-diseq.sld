(define-library (miruKanren eqeq-diseq)

  (import (scheme base)
          (miruKanren kanren)
          (miruKanren monad)
          (miruKanren unification))

  (export == =/=)

  (include "eqeq-diseq.scm"))
