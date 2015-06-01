(define-library (miruKanren unification)

  (import (scheme base)
          (scheme cxr)
          (miruKanren substitution)
          (miruKanren utils)
          (miruKanren variables)
          (miruKanren record-inspection))

  (export walk
          walk*
          occurs-check
          extend-substitution/prefix
          unify/prefix
          unify)

  (include "unification-records.scm"))

