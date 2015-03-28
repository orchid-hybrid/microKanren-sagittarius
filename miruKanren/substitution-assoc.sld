(define-library (miruKanren substitution-assoc)

  (import (scheme base))

  (export substitution-lookup
          substitution-not-found
          substitution-update
          substitution-size
          empty-substitution)

  (include "substitution-assoc.scm"))
