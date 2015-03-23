(define-library (miruKanren disequality)

  (import (scheme base)
          (miruKanren utils)
          (miruKanren kanren)
          (miruKanren monad)
          (miruKanren unification))

  (export disequality
          disequality/assoc
          normalize-disequality-store)

  (include "disequality.scm"))
