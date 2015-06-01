(define-library (miruKanren substitution)

  (import (scheme base)
          (miruKanren utils)
          (miruKanren variables))

  (export substitution-set
          substitution-get
          substitution-size
          empty-substitution)

  (include "substitution-assoc.scm"))

