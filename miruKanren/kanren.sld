(define-library (miruKanren kanren)

  (import (scheme base))

  (export make-kanren
          kanren?

          counter
          substitution
          surveillance

          initial-kanren

          modified-counter
          modified-substitution
          modified-surveillance)

  (include "kanren.scm"))

