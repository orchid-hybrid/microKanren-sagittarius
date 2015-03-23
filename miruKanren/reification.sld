(define-library (miruKanren reification)

  (import (scheme base)
          (miruKanren variables)
          (miruKanren unification)
          (miruKanren kanren))

  (export reify-name
          reify-term
          reify-kanren)

  (include "reification.scm"))
