(define-library (miruKanren micro)

  (import (scheme base)
          (miruKanren kanren)
          (miruKanren variables)
          (miruKanren monad))

  (export call/fresh
          disj
          conj)

  (include "micro.scm"))
