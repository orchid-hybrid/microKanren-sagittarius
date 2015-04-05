(define-library (miruKanren copy-term)

  (import (scheme base)
          (miruKanren kanren)
          (miruKanren variables)
          (miruKanren unification)
          (miruKanren eqeq)
          (miruKanren micro))

  (export copy-termo)

  (include "copy-term.scm"))

