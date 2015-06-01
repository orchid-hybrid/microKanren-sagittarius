(define-library (miruKanren substitution)

  (import (scheme base)
          (llrb-tree llrb-tree)
          (miruKanren utils)
          (miruKanren variables))

  (export substitution-set
          substitution-get
          substitution-size
          empty-substitution)

  (include "substitution-llrb-tree.scm"))
