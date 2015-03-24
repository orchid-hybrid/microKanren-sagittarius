(define-library (miruKanren eqeq-watch)

  (import (scheme base)
          (miruKanren utils)
          (miruKanren variables)
          (miruKanren kanren)
          (miruKanren monad)
          (miruKanren mini)
          (miruKanren bijections)
          (miruKanren unification)
          (miruKanren surveillance))

  (export == watch
          bijectiono
          peanoo binaryo)

  (include "eqeq-watch.scm"))
