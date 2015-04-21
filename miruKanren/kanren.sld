(define-library (miruKanren kanren)

  (import (scheme base))

  (export make-kanren
          kanren?

          counter
          substitution
          disequality-store
          type-store
          surveillance
	  domains

          initial-kanren

          modified-counter
          modified-substitution
          modified-disequality-store
          modified-type-store
          modified-surveillance
	  modified-domains)

  (include "kanren.scm"))
