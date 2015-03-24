(define-library (miruKanren type)

  (import (scheme base)
          (miruKanren utils)
          (miruKanren variables)
          (miruKanren kanren)
          (miruKanren monad)
          (miruKanren micro)
          (miruKanren unification)
          (miruKanren disequality))

  (export normalize-type-store
          call/type-of-var)

  (include "type.scm"))
