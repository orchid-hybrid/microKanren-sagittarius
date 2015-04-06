(define-library (miruKanren unification)

  (import (scheme base)
          (miruKanren utils)
          (miruKanren variables))

  (export walk
          walk*
          occurs-check
          extend-substitution/prefix
          unify/prefix
          unify)

  (include "unification-basic.scm"))

