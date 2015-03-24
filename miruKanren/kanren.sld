(define-library (miruKanren kanren)

  (import (scheme base))

  (export make-kanren
          kanren?

          counter
          substitution
          disequality-store
          type-store
          surveillance

          initial-kanren

          modified-counter
          modified-substitution
          modified-disequality-store
          modified-type-store
          modified-surveillance)

  (include "kanren.scm"))
