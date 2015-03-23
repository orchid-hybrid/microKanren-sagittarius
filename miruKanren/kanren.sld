(define-library (miruKanren kanren)

  (import (scheme base))

  (export make-kanren
          kanren?

          counter
          substitution
          disequality-store
          surveillance

          initial-kanren

          modified-counter
          modified-substitution
          modified-disequality-store
          modified-surveillance)

  (include "kanren.scm"))

