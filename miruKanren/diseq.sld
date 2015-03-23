(define-library (miruKanren diseq)

  (import (miruKanren mini)
          (miruKanren run)
          (miruKanren eqeq-diseq))

  (export == =/= fresh conde
          run^ run* runi))
