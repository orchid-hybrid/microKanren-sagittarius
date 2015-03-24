(define-library (miruKanren surveillance)

  (import (scheme base)
          (miruKanren sorted-int-set)
          (miruKanren utils)
          (miruKanren variables)
          (miruKanren kanren)
          (miruKanren monad)
          (miruKanren unification))

  (export variables-in-term
          normalize-surveillance)

  (include "surveillance.scm"))
