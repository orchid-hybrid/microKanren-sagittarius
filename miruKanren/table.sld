(define-library (miruKanren table)

  (import (scheme base)
          (miruKanren unification)
          (miruKanren variables)
          (miruKanren kanren)
          (miruKanren micro)
          (miruKanren mini)
          (miruKanren eqeq)
          (miruKanren streams)
          (miruKanren copy-term))

  (export make-table
  	  table-membero)

  (include "table.scm"))

